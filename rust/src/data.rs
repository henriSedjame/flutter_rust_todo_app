

const FORMAT: &str = "%Y-%m-%d %H:%M:%S";

pub mod entities {
    use mobc_postgres::tokio_postgres::Row;
    use postgres_types::{FromSql, ToSql, Type};
    use serde:: {Deserialize, Serialize};
    use uuid::Uuid;

    #[derive(Deserialize, Serialize, Debug, Clone, FromSql, ToSql)]
    pub struct TodoEntity {
        pub id: String,
        pub data: serde_json::Value
    }

    impl TodoEntity {
        pub fn with_data(data: serde_json::Value) -> Self {
            Self {
                id: Uuid::new_v4().to_string(),
                data
            }
        }
    }

    impl From<Row> for TodoEntity {
        fn from(row: Row) -> Self {
            Self {
                id: row.get("id"),
                data: row.get("data")
            }
        }
    }
}

pub mod dto {
    use chrono::Utc;
    use serde:: {Deserialize, Serialize};
    use crate::data::FORMAT;

    #[derive(Deserialize, Serialize, Debug, Clone)]
    pub enum Status {
        UNDONE ,
        DONE,
    }

    #[derive(Deserialize, Serialize, Debug, Clone)]
    pub struct TodoData {
        pub label: String,
        pub status: Status,
        pub created_at: String
    }

    #[derive(Deserialize, Serialize, Debug, Clone)]
    pub struct Todo {
        pub id: String,
        pub data: Option<TodoData>
    }

    impl Default for TodoData {
        fn default() -> Self {
            TodoData {
                label: String::default(),
                status: Status::UNDONE,
                created_at: Utc::now().format(FORMAT).to_string()
            }
        }
    }

    impl TodoData {
        pub fn with_label(label: String) -> Self {
            Self {
                label,
                status: Status::UNDONE,
                created_at: Utc::now().format(FORMAT).to_string()
            }
        }

        pub fn from_json(value: serde_json::Value) -> Self {
            serde_json::from_value::<TodoData>(value).expect("Fail to deserialize value")
        }

        pub fn to_json(&self) -> serde_json::Value {
            serde_json::to_value(self).expect("Fail to serialize todo data")
        }
    }

    pub mod requests {
        use serde:: {Deserialize, Serialize};

        use crate::data::dto::Status;

        #[derive(Deserialize, Serialize, Debug, Clone)]
        pub struct CreateTodoRequest {
            pub label:String
        }

        #[derive(Deserialize, Serialize, Debug, Clone)]
        pub struct UpdateTodoRequest {
            pub status: Status
        }

        #[derive(Deserialize, Serialize, Debug, Clone)]
        pub struct DeleteTodoRequest {
            pub id: String
        }
    }

    pub mod events {
        use serde:: {Deserialize, Serialize};

        use crate::data::dto::Todo;

        #[derive(Deserialize, Serialize, Debug, Clone)]
        pub enum EventType {
            Created,
            Updated,
            Deleted,
            Error
        }

        #[derive(Deserialize, Serialize, Debug, Clone)]
        pub struct TodoEvent {
            pub event_type: EventType,
            pub error_message: Option<String>,
            pub data: Option<Todo>,
        }
    }

}

pub mod mappers {
    use crate::data::dto::{Todo, TodoData};
    use crate::data::dto::requests::CreateTodoRequest;
    use crate::data::entities::TodoEntity;

    pub fn create_request_to_entity(request: CreateTodoRequest) -> TodoEntity {
        TodoEntity::with_data(TodoData::with_label(request.label).to_json())
    }

    pub fn entity_to_dto(entity: TodoEntity) -> Todo {
        Todo {
            id: entity.id,
            data: Some(TodoData::from_json(entity.data))
        }
    }

}


