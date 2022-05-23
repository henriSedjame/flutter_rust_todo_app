
use std::sync::{Arc, Mutex};
use crate::types::DBPool;

use anyhow::Result;
use crate::data::entities::TodoEntity;

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

    Ok(TodoEntity::from(result))
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