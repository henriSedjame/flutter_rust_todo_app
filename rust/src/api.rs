
use std::str::FromStr;
use std::sync::{Arc, Mutex};
use lazy_static::lazy_static;
use mobc_postgres::{PgConnectionManager};
use mobc_postgres::tokio_postgres::Config;
use anyhow::Result;
use mobc::{Connection, Pool};
use flutter_rust_bridge::StreamSink;
use openssl::ssl::{SslConnector, SslMethod, SslVerifyMode};
use postgres_openssl::{MakeTlsConnector};
use crate::config::AppConfig;
use std::time::Duration;
use crate::data::{
    dto::{
        Todo,
        events::{EventType, TodoEvent},
        requests::{CreateTodoRequest, UpdateTodoRequest},
    },
};
use crate::data::mappers::{create_request_to_entity, entity_to_dto};
use crate::logging::{Logger, LogLevel, LogMessage};
use crate::repos::{create, delete, get_all, init, update};


use crate::types::DBPool;

const DB_POOL_MAX_OPEN: u64 = 32;
const DB_POOL_MAX_IDLE: u64 = 8;
const DB_POOL_TIMEOUT_SECONDS: u64 = 15;

lazy_static!  {

    static ref APP_CONFIG: once_cell::sync::OnceCell<AppConfig> = once_cell::sync::OnceCell::new();


    static ref DB_POOL : async_once::AsyncOnce<Arc<Mutex<DBPool>>> = async_once::AsyncOnce::new(async {

        let app_config = APP_CONFIG.get().unwrap();

        let config_str = app_config.datasource.to_string();

        log(config_str.clone());

        let config = Config::from_str(config_str.as_str()).unwrap();

        log("Config is built successfully".to_string());
        
        let mut ssl_builder = SslConnector::builder(SslMethod::tls()).unwrap();
        ssl_builder.set_verify(SslVerifyMode::NONE);
        let connector = MakeTlsConnector::new(ssl_builder.build());

        let manager = PgConnectionManager::new(config, connector);

        log("PgConnectionManager is created successfully".to_string());


        let pool =  Pool::builder()
                .max_open(DB_POOL_MAX_OPEN)
                .max_idle(DB_POOL_MAX_IDLE)
                .get_timeout(Some(Duration::from_secs(DB_POOL_TIMEOUT_SECONDS)))
                .build(manager);

        log("PgPool is created successfully".to_string());

        Arc::new(Mutex::new( pool ))
    });

    static ref TODO_EVENTS_STREAM: once_cell::sync::OnceCell<StreamSink<TodoEvent>> = once_cell::sync::OnceCell::new();

    static ref LOGGER: once_cell::sync::OnceCell<Arc<Mutex<Logger>>> = once_cell::sync::OnceCell::new();
}

/// Cette methode permet de générer une impl de DartCObject pour l'objet TodoEvent
pub fn dummy_todo_event(todo_event: TodoEvent) {}

pub fn dummy_log_message(log_message: LogMessage) {}

/// ## Init log stream
///
pub fn log_stream(stream: StreamSink<LogMessage>) -> Result<()> {
    LOGGER.get_or_init(||{ Arc::new(Mutex::new(Logger::new(stream) ))});
    Ok(())
}

/// ## Load App Config
///
/// Cette méthode permet de charger la configuration de l'application
pub fn load_app_config(config: String) -> Result<()> {
    let app_config: AppConfig = serde_yaml::from_str(&config)?;

    APP_CONFIG.get_or_init(|| {
        app_config
    });

    Ok(())
}

/// ## Todo Events
///
/// Cette méthode permet de créer un Stream de TodoEvent
///
/// à travers lequel des messages pourront être envoyés de Rust -> Flutter
pub fn todo_events(stream: StreamSink<TodoEvent>) -> Result<()> {
    TODO_EVENTS_STREAM.get_or_init(|| { stream });
    Ok(())
}

/// ## Init Db
///
/// Cette méthode permet d'initialiser la base de données
#[tokio::main(flavor = "current_thread")]
pub async fn init_db() -> Result<()> {

    let pool = DB_POOL.get().await;

    match  init(pool).await {
        Ok(_) => {
            Ok(())
        }
        Err(e) => {
            log(e.to_string());
            Err(e)
        }
    }
}

/// ## Create Todo
///
/// Cette méthode permet de créer un Todo
///
/// A la création du Todo, un event est envoyé
#[tokio::main(flavor = "current_thread")]
pub async fn create_todo(request: CreateTodoRequest) -> Result<()> {
    let pool = DB_POOL.get().await;

    let entity = create_request_to_entity(request);

    handle(
        create(pool, &entity).await,
        |e|{
            TodoEvent {
                event_type: EventType::Created,
                error_message: None,
                data: Some(entity_to_dto(e)),
            }
        }
    );

    Ok(())
}

#[tokio::main(flavor = "current_thread")]
pub async fn update_todo(id: String, request: UpdateTodoRequest) -> Result<()> {
    let pool = DB_POOL.get().await;

    let data = serde_json::to_value(request)?;

    handle(
        update(pool, id, data).await,
        |e| {
            TodoEvent {
                event_type: EventType::Updated,
                error_message: None,
                data: Some(entity_to_dto(e)),
            }
        },
    );


    Ok(())
}


#[tokio::main(flavor = "current_thread")]
pub async fn delete_todo(id: String) -> Result<()> {
    let pool = DB_POOL.get().await;

    handle(
        delete(pool, id.clone()).await,
        |(deleted, todo_id)| {
            match deleted {
                true => TodoEvent {
                    event_type: EventType::Deleted,
                    error_message: None,
                    data: Some(Todo{id: todo_id, data: None}),
                },
                false => TodoEvent {
                    event_type: EventType::Error,
                    error_message: Some("Fail to delete todo".to_string()),
                    data: None,
                }
            }
        }
    );

    Ok(())
}

/// Get All Todos
///
/// Cette méthode permet de récupérer tous les Todos
#[tokio::main(flavor = "current_thread")]
pub async fn get_all_todos() -> Result<Vec<Todo>> {

    let pool = DB_POOL.get().await;
    
    let todos = get_all(pool).await?;
    
    let datas = todos.into_iter().map(move |t| {
        entity_to_dto(t)
    }).collect();


    Ok(datas)
}

fn handle<T>(result: Result<T>, event: fn(T) -> TodoEvent) {
    let evt = match result {
        Ok(t) => event(t),
        Err(e) => {
            TodoEvent {
                event_type: EventType::Error,
                error_message: Some(e.to_string()),
                data: None,
            }
        }
    };

    TODO_EVENTS_STREAM.get().unwrap().add(evt);
}

fn log(message: String) {
    LOGGER.get()
        .unwrap()
        .lock()
        .unwrap()
        .log(LogMessage{level: LogLevel::INFO, message});

}