
use serde::{Deserialize, Serialize};
use tokio::fs::read_to_string;



#[derive(Debug, PartialEq, Serialize, Deserialize)]
pub struct DBConfig {
    pub host: String,
    pub port: u32,
    pub username: String,
    pub password: String,
    pub database: String,
    pub ssl_mode: String,
}

/// ToString trait implementation
impl ToString for DBConfig {
    /// ##ToString
    ///
    /// Returns the database url
    fn to_string(&self) -> String {
        format!(
            "postgres://{}:{}@{}:{}/{}?sslmode={}",
             self.username, self.password, self.host, self.port, self.database, self.ssl_mode
        )
    }
}

#[derive(Debug, PartialEq, Serialize, Deserialize)]
pub struct AppConfig {
    pub datasource: DBConfig
}

pub async fn init_config(path: &str) -> anyhow::Result<AppConfig> {

    let content = read_to_string(path).await?;

    let config: AppConfig = serde_yaml::from_str(&content)?;

    Ok(config)
}