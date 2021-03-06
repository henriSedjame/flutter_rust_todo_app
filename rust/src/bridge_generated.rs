#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`.

use crate::api::*;
use flutter_rust_bridge::*;

// Section: imports

use crate::data::dto::events::EventType;
use crate::data::dto::events::TodoEvent;
use crate::data::dto::requests::CreateTodoRequest;
use crate::data::dto::requests::UpdateTodoRequest;
use crate::data::dto::Status;
use crate::data::dto::Todo;
use crate::data::dto::TodoData;
use crate::logging::LogLevel;
use crate::logging::LogMessage;

// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_dummy_todo_event(port_: i64, todo_event: *mut wire_TodoEvent) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "dummy_todo_event",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_todo_event = todo_event.wire2api();
            move |task_callback| Ok(dummy_todo_event(api_todo_event))
        },
    )
}

#[no_mangle]
pub extern "C" fn wire_dummy_log_message(port_: i64, log_message: *mut wire_LogMessage) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "dummy_log_message",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_log_message = log_message.wire2api();
            move |task_callback| Ok(dummy_log_message(api_log_message))
        },
    )
}

#[no_mangle]
pub extern "C" fn wire_log_stream(port_: i64) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "log_stream",
            port: Some(port_),
            mode: FfiCallMode::Stream,
        },
        move || move |task_callback| log_stream(task_callback.stream_sink()),
    )
}

#[no_mangle]
pub extern "C" fn wire_load_app_config(port_: i64, config: *mut wire_uint_8_list) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "load_app_config",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_config = config.wire2api();
            move |task_callback| load_app_config(api_config)
        },
    )
}

#[no_mangle]
pub extern "C" fn wire_todo_events(port_: i64) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "todo_events",
            port: Some(port_),
            mode: FfiCallMode::Stream,
        },
        move || move |task_callback| todo_events(task_callback.stream_sink()),
    )
}

#[no_mangle]
pub extern "C" fn wire_init_db(port_: i64) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "init_db",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| init_db(),
    )
}

#[no_mangle]
pub extern "C" fn wire_create_todo(port_: i64, request: *mut wire_CreateTodoRequest) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "create_todo",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_request = request.wire2api();
            move |task_callback| create_todo(api_request)
        },
    )
}

#[no_mangle]
pub extern "C" fn wire_update_todo(
    port_: i64,
    id: *mut wire_uint_8_list,
    request: *mut wire_UpdateTodoRequest,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "update_todo",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_id = id.wire2api();
            let api_request = request.wire2api();
            move |task_callback| update_todo(api_id, api_request)
        },
    )
}

#[no_mangle]
pub extern "C" fn wire_delete_todo(port_: i64, id: *mut wire_uint_8_list) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "delete_todo",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_id = id.wire2api();
            move |task_callback| delete_todo(api_id)
        },
    )
}

#[no_mangle]
pub extern "C" fn wire_get_all_todos(port_: i64) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "get_all_todos",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| get_all_todos(),
    )
}

// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_CreateTodoRequest {
    label: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_LogMessage {
    level: i32,
    message: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Todo {
    id: *mut wire_uint_8_list,
    data: *mut wire_TodoData,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_TodoData {
    label: *mut wire_uint_8_list,
    status: i32,
    created_at: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_TodoEvent {
    event_type: i32,
    error_message: *mut wire_uint_8_list,
    data: *mut wire_Todo,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_UpdateTodoRequest {
    status: i32,
}

// Section: wrapper structs

// Section: static checks

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_box_autoadd_create_todo_request() -> *mut wire_CreateTodoRequest {
    support::new_leak_box_ptr(wire_CreateTodoRequest::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_log_message() -> *mut wire_LogMessage {
    support::new_leak_box_ptr(wire_LogMessage::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_todo() -> *mut wire_Todo {
    support::new_leak_box_ptr(wire_Todo::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_todo_data() -> *mut wire_TodoData {
    support::new_leak_box_ptr(wire_TodoData::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_todo_event() -> *mut wire_TodoEvent {
    support::new_leak_box_ptr(wire_TodoEvent::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_update_todo_request() -> *mut wire_UpdateTodoRequest {
    support::new_leak_box_ptr(wire_UpdateTodoRequest::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_uint_8_list(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        if self.is_null() {
            None
        } else {
            Some(self.wire2api())
        }
    }
}

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}

impl Wire2Api<CreateTodoRequest> for *mut wire_CreateTodoRequest {
    fn wire2api(self) -> CreateTodoRequest {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        (*wrap).wire2api().into()
    }
}

impl Wire2Api<LogMessage> for *mut wire_LogMessage {
    fn wire2api(self) -> LogMessage {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        (*wrap).wire2api().into()
    }
}

impl Wire2Api<Todo> for *mut wire_Todo {
    fn wire2api(self) -> Todo {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        (*wrap).wire2api().into()
    }
}

impl Wire2Api<TodoData> for *mut wire_TodoData {
    fn wire2api(self) -> TodoData {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        (*wrap).wire2api().into()
    }
}

impl Wire2Api<TodoEvent> for *mut wire_TodoEvent {
    fn wire2api(self) -> TodoEvent {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        (*wrap).wire2api().into()
    }
}

impl Wire2Api<UpdateTodoRequest> for *mut wire_UpdateTodoRequest {
    fn wire2api(self) -> UpdateTodoRequest {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        (*wrap).wire2api().into()
    }
}

impl Wire2Api<CreateTodoRequest> for wire_CreateTodoRequest {
    fn wire2api(self) -> CreateTodoRequest {
        CreateTodoRequest {
            label: self.label.wire2api(),
        }
    }
}

impl Wire2Api<EventType> for i32 {
    fn wire2api(self) -> EventType {
        match self {
            0 => EventType::Created,
            1 => EventType::Updated,
            2 => EventType::Deleted,
            3 => EventType::Error,
            _ => unreachable!("Invalid variant for EventType: {}", self),
        }
    }
}

impl Wire2Api<LogLevel> for i32 {
    fn wire2api(self) -> LogLevel {
        match self {
            0 => LogLevel::INFO,
            1 => LogLevel::WARNING,
            2 => LogLevel::ERROR,
            _ => unreachable!("Invalid variant for LogLevel: {}", self),
        }
    }
}

impl Wire2Api<LogMessage> for wire_LogMessage {
    fn wire2api(self) -> LogMessage {
        LogMessage {
            level: self.level.wire2api(),
            message: self.message.wire2api(),
        }
    }
}

impl Wire2Api<Status> for i32 {
    fn wire2api(self) -> Status {
        match self {
            0 => Status::UNDONE,
            1 => Status::DONE,
            _ => unreachable!("Invalid variant for Status: {}", self),
        }
    }
}

impl Wire2Api<Todo> for wire_Todo {
    fn wire2api(self) -> Todo {
        Todo {
            id: self.id.wire2api(),
            data: self.data.wire2api(),
        }
    }
}

impl Wire2Api<TodoData> for wire_TodoData {
    fn wire2api(self) -> TodoData {
        TodoData {
            label: self.label.wire2api(),
            status: self.status.wire2api(),
            created_at: self.created_at.wire2api(),
        }
    }
}

impl Wire2Api<TodoEvent> for wire_TodoEvent {
    fn wire2api(self) -> TodoEvent {
        TodoEvent {
            event_type: self.event_type.wire2api(),
            error_message: self.error_message.wire2api(),
            data: self.data.wire2api(),
        }
    }
}

impl Wire2Api<u8> for u8 {
    fn wire2api(self) -> u8 {
        self
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}

impl Wire2Api<UpdateTodoRequest> for wire_UpdateTodoRequest {
    fn wire2api(self) -> UpdateTodoRequest {
        UpdateTodoRequest {
            status: self.status.wire2api(),
        }
    }
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

impl NewWithNullPtr for wire_CreateTodoRequest {
    fn new_with_null_ptr() -> Self {
        Self {
            label: core::ptr::null_mut(),
        }
    }
}

impl NewWithNullPtr for wire_LogMessage {
    fn new_with_null_ptr() -> Self {
        Self {
            level: Default::default(),
            message: core::ptr::null_mut(),
        }
    }
}

impl NewWithNullPtr for wire_Todo {
    fn new_with_null_ptr() -> Self {
        Self {
            id: core::ptr::null_mut(),
            data: core::ptr::null_mut(),
        }
    }
}

impl NewWithNullPtr for wire_TodoData {
    fn new_with_null_ptr() -> Self {
        Self {
            label: core::ptr::null_mut(),
            status: Default::default(),
            created_at: core::ptr::null_mut(),
        }
    }
}

impl NewWithNullPtr for wire_TodoEvent {
    fn new_with_null_ptr() -> Self {
        Self {
            event_type: Default::default(),
            error_message: core::ptr::null_mut(),
            data: core::ptr::null_mut(),
        }
    }
}

impl NewWithNullPtr for wire_UpdateTodoRequest {
    fn new_with_null_ptr() -> Self {
        Self {
            status: Default::default(),
        }
    }
}

// Section: impl IntoDart

impl support::IntoDart for EventType {
    fn into_dart(self) -> support::DartCObject {
        match self {
            Self::Created => 0,
            Self::Updated => 1,
            Self::Deleted => 2,
            Self::Error => 3,
        }
        .into_dart()
    }
}

impl support::IntoDart for LogLevel {
    fn into_dart(self) -> support::DartCObject {
        match self {
            Self::INFO => 0,
            Self::WARNING => 1,
            Self::ERROR => 2,
        }
        .into_dart()
    }
}

impl support::IntoDart for LogMessage {
    fn into_dart(self) -> support::DartCObject {
        vec![self.level.into_dart(), self.message.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for LogMessage {}

impl support::IntoDart for Status {
    fn into_dart(self) -> support::DartCObject {
        match self {
            Self::UNDONE => 0,
            Self::DONE => 1,
        }
        .into_dart()
    }
}

impl support::IntoDart for Todo {
    fn into_dart(self) -> support::DartCObject {
        vec![self.id.into_dart(), self.data.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Todo {}

impl support::IntoDart for TodoData {
    fn into_dart(self) -> support::DartCObject {
        vec![
            self.label.into_dart(),
            self.status.into_dart(),
            self.created_at.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for TodoData {}

impl support::IntoDart for TodoEvent {
    fn into_dart(self) -> support::DartCObject {
        vec![
            self.event_type.into_dart(),
            self.error_message.into_dart(),
            self.data.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for TodoEvent {}

// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturnStruct(val: support::WireSyncReturnStruct) {
    unsafe {
        let _ = support::vec_from_leak_ptr(val.ptr, val.len);
    }
}
