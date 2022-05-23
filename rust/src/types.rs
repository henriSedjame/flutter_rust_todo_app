
use mobc_postgres::PgConnectionManager;
use mobc::{Connection, Pool};
use mobc_postgres::tokio_postgres::NoTls;

/// Connection of PgConnectionManager
pub type DBConn = Connection<PgConnectionManager<NoTls>>;

/// Pool of PgConnectionManager
pub type DBPool = Pool<PgConnectionManager<NoTls>>;