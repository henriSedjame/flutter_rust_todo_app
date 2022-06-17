
use std::sync::{Arc, Mutex};
use crate::types::DBPool;

use anyhow::Result;
use mobc_postgres::tokio_postgres::AsyncMessage::Notification;
use mobc_postgres::tokio_postgres::GenericClient;
use crate::data::dto::events::{EventType, TodoEvent};
use crate::data::dto::{Todo, TodoData};
use crate::data::entities::TodoEntity;

const NOTIFIY_SQL: &str = "NOTIFIY 'new_todo', $2";
const INSERT_SQL: &str = "INSERT INTO TODOS(id, data) VALUES ($1, $2) RETURNING *";
const UPDATE_SQL : &str = "UPDATE todos set data = data || $1 where id= $2 RETURNING *";
const DELETE_SQL : &str = "DELETE FROM TODOS WHERE id = $1";
const FIND_ALL_SQL: &str = "SELECT * FROM TODOS";
const INIT: &str = "
        CREATE TABLE  IF NOT EXISTS TODOS(
        id  VARCHAR(255) PRIMARY KEY NOT NULL,
        data JSONB NOT NULL)
       ";


pub async fn init(pool: &Arc<Mutex<DBPool>>) ->  Result<()>{
    let conn = pool.lock().unwrap().get().await?;
    conn.batch_execute(INIT).await?;
    Ok(())
}

pub async fn create(pool: &Arc<Mutex<DBPool>>, todo: &TodoEntity) -> Result<TodoEntity> {
    let conn = pool.lock().unwrap().get().await?;
    let result  = conn.query_one(INSERT_SQL, &[&todo.id,  &todo.data]).await?;
    let entity = TodoEntity::from(result);

    let event = TodoEvent{
        event_type: EventType::Created,
        error_message: None,
        data: Some( Todo {
            id: entity.clone().id,
            data: Some(TodoData::from_json(entity.clone().data))
        })
    };

    let event_str = serde_json::to_string(&event).unwrap();

    conn.execute(NOTIFIY_SQL, &[&event_str]).await?;

    Ok(entity)
}

pub async fn update(pool: &Arc<Mutex<DBPool>>, id: String, data: serde_json::Value) -> Result<TodoEntity> {
    let conn = pool.lock().unwrap().get().await?;
    let row = conn.query_one(UPDATE_SQL, &[&data, &id]).await?;
    Ok(TodoEntity::from(row))
}

pub async fn delete(pool: &Arc<Mutex<DBPool>>, id: String) -> Result<(bool, String)> {
    let conn = pool.lock().unwrap().get().await?;
    let nb = conn.execute(DELETE_SQL, &[&id]).await?;
    Ok((nb == 1, id))
}

pub async fn get_all(pool: &Arc<Mutex<DBPool>>) -> Result<Vec<TodoEntity>> {
    let conn = pool.lock().unwrap().get().await?;
    let result = conn.query(FIND_ALL_SQL, &[]).await?;
    let todos = result.into_iter().map(|row| TodoEntity::from(row)).collect::<Vec<TodoEntity>>();
    Ok(todos)
}

pub async fn listen(pool: &Arc<Mutex<DBPool>>,sender: std::sync::mpsc::Sender<String>, rec: std::sync::mpsc::Receiver<bool>) -> Result<()> {

    let conn = pool.lock().unwrap().get().await?;

    let events = conn.query("LISTEN nex_todo", &[]).await?;

    events.into_iter().for_each(|row | {
        sender.send(row.get("id")).unwrap();
    });

    rec.recv()?;

    Ok(())
}