
use mobc_postgres::PgConnectionManager;
use mobc::{Connection, Pool};
use mobc_postgres::tokio_postgres::NoTls;
use postgres_openssl::MakeTlsConnector;

/// Connection of PgConnectionManager
pub type DBConn = Connection<PgConnectionManager<NoTls>>;

/// Pool of PgConnectionManager
pub type DBPool = Pool<PgConnectionManager<MakeTlsConnector>>;