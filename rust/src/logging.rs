use std::sync::{Arc, Mutex};
use flutter_rust_bridge::StreamSink;

pub enum LogLevel {
    INFO, WARNING, ERROR
}
pub struct LogMessage {
    pub level: LogLevel,
    pub message: String,
}

pub struct Logger {
    pub stream: StreamSink<LogMessage>
}

impl Logger {
    pub fn new(stream: StreamSink<LogMessage>) -> Self {
        Self{ stream }
    }

    pub fn log(&self, message: LogMessage) {
        self.stream.add(message);
    }
}