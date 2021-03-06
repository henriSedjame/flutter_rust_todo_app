// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`.

// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, prefer_single_quotes, prefer_const_constructors

import "todo_services.dart";
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'dart:ffi' as ffi;

class TodoServicesImpl extends FlutterRustBridgeBase<TodoServicesWire>
    implements TodoServices {
  factory TodoServicesImpl(ffi.DynamicLibrary dylib) =>
      TodoServicesImpl.raw(TodoServicesWire(dylib));

  TodoServicesImpl.raw(TodoServicesWire inner) : super(inner);

  Future<void> dummyTodoEvent({required TodoEvent todoEvent, dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_dummy_todo_event(
            port_, _api2wire_box_autoadd_todo_event(todoEvent)),
        parseSuccessData: _wire2api_unit,
        constMeta: const FlutterRustBridgeTaskConstMeta(
          debugName: "dummy_todo_event",
          argNames: ["todoEvent"],
        ),
        argValues: [todoEvent],
        hint: hint,
      ));

  Future<void> dummyLogMessage(
          {required LogMessage logMessage, dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_dummy_log_message(
            port_, _api2wire_box_autoadd_log_message(logMessage)),
        parseSuccessData: _wire2api_unit,
        constMeta: const FlutterRustBridgeTaskConstMeta(
          debugName: "dummy_log_message",
          argNames: ["logMessage"],
        ),
        argValues: [logMessage],
        hint: hint,
      ));

  Stream<LogMessage> logStream({dynamic hint}) =>
      executeStream(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_log_stream(port_),
        parseSuccessData: _wire2api_log_message,
        constMeta: const FlutterRustBridgeTaskConstMeta(
          debugName: "log_stream",
          argNames: [],
        ),
        argValues: [],
        hint: hint,
      ));

  Future<void> loadAppConfig({required String config, dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) =>
            inner.wire_load_app_config(port_, _api2wire_String(config)),
        parseSuccessData: _wire2api_unit,
        constMeta: const FlutterRustBridgeTaskConstMeta(
          debugName: "load_app_config",
          argNames: ["config"],
        ),
        argValues: [config],
        hint: hint,
      ));

  Stream<TodoEvent> todoEvents({dynamic hint}) =>
      executeStream(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_todo_events(port_),
        parseSuccessData: _wire2api_todo_event,
        constMeta: const FlutterRustBridgeTaskConstMeta(
          debugName: "todo_events",
          argNames: [],
        ),
        argValues: [],
        hint: hint,
      ));

  Future<void> initDb({dynamic hint}) => executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_init_db(port_),
        parseSuccessData: _wire2api_unit,
        constMeta: const FlutterRustBridgeTaskConstMeta(
          debugName: "init_db",
          argNames: [],
        ),
        argValues: [],
        hint: hint,
      ));

  Future<void> createTodo({required CreateTodoRequest request, dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_create_todo(
            port_, _api2wire_box_autoadd_create_todo_request(request)),
        parseSuccessData: _wire2api_unit,
        constMeta: const FlutterRustBridgeTaskConstMeta(
          debugName: "create_todo",
          argNames: ["request"],
        ),
        argValues: [request],
        hint: hint,
      ));

  Future<void> updateTodo(
          {required String id,
          required UpdateTodoRequest request,
          dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_update_todo(port_, _api2wire_String(id),
            _api2wire_box_autoadd_update_todo_request(request)),
        parseSuccessData: _wire2api_unit,
        constMeta: const FlutterRustBridgeTaskConstMeta(
          debugName: "update_todo",
          argNames: ["id", "request"],
        ),
        argValues: [id, request],
        hint: hint,
      ));

  Future<void> deleteTodo({required String id, dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_delete_todo(port_, _api2wire_String(id)),
        parseSuccessData: _wire2api_unit,
        constMeta: const FlutterRustBridgeTaskConstMeta(
          debugName: "delete_todo",
          argNames: ["id"],
        ),
        argValues: [id],
        hint: hint,
      ));

  Future<List<Todo>> getAllTodos({dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_get_all_todos(port_),
        parseSuccessData: _wire2api_list_todo,
        constMeta: const FlutterRustBridgeTaskConstMeta(
          debugName: "get_all_todos",
          argNames: [],
        ),
        argValues: [],
        hint: hint,
      ));

  // Section: api2wire
  ffi.Pointer<wire_uint_8_list> _api2wire_String(String raw) {
    return _api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  ffi.Pointer<wire_CreateTodoRequest> _api2wire_box_autoadd_create_todo_request(
      CreateTodoRequest raw) {
    final ptr = inner.new_box_autoadd_create_todo_request();
    _api_fill_to_wire_create_todo_request(raw, ptr.ref);
    return ptr;
  }

  ffi.Pointer<wire_LogMessage> _api2wire_box_autoadd_log_message(
      LogMessage raw) {
    final ptr = inner.new_box_autoadd_log_message();
    _api_fill_to_wire_log_message(raw, ptr.ref);
    return ptr;
  }

  ffi.Pointer<wire_Todo> _api2wire_box_autoadd_todo(Todo raw) {
    final ptr = inner.new_box_autoadd_todo();
    _api_fill_to_wire_todo(raw, ptr.ref);
    return ptr;
  }

  ffi.Pointer<wire_TodoData> _api2wire_box_autoadd_todo_data(TodoData raw) {
    final ptr = inner.new_box_autoadd_todo_data();
    _api_fill_to_wire_todo_data(raw, ptr.ref);
    return ptr;
  }

  ffi.Pointer<wire_TodoEvent> _api2wire_box_autoadd_todo_event(TodoEvent raw) {
    final ptr = inner.new_box_autoadd_todo_event();
    _api_fill_to_wire_todo_event(raw, ptr.ref);
    return ptr;
  }

  ffi.Pointer<wire_UpdateTodoRequest> _api2wire_box_autoadd_update_todo_request(
      UpdateTodoRequest raw) {
    final ptr = inner.new_box_autoadd_update_todo_request();
    _api_fill_to_wire_update_todo_request(raw, ptr.ref);
    return ptr;
  }

  int _api2wire_event_type(EventType raw) {
    return raw.index;
  }

  int _api2wire_log_level(LogLevel raw) {
    return raw.index;
  }

  ffi.Pointer<wire_uint_8_list> _api2wire_opt_String(String? raw) {
    return raw == null ? ffi.nullptr : _api2wire_String(raw);
  }

  ffi.Pointer<wire_Todo> _api2wire_opt_box_autoadd_todo(Todo? raw) {
    return raw == null ? ffi.nullptr : _api2wire_box_autoadd_todo(raw);
  }

  ffi.Pointer<wire_TodoData> _api2wire_opt_box_autoadd_todo_data(
      TodoData? raw) {
    return raw == null ? ffi.nullptr : _api2wire_box_autoadd_todo_data(raw);
  }

  int _api2wire_status(Status raw) {
    return raw.index;
  }

  int _api2wire_u8(int raw) {
    return raw;
  }

  ffi.Pointer<wire_uint_8_list> _api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }

  // Section: api_fill_to_wire

  void _api_fill_to_wire_box_autoadd_create_todo_request(
      CreateTodoRequest apiObj, ffi.Pointer<wire_CreateTodoRequest> wireObj) {
    _api_fill_to_wire_create_todo_request(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_box_autoadd_log_message(
      LogMessage apiObj, ffi.Pointer<wire_LogMessage> wireObj) {
    _api_fill_to_wire_log_message(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_box_autoadd_todo(
      Todo apiObj, ffi.Pointer<wire_Todo> wireObj) {
    _api_fill_to_wire_todo(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_box_autoadd_todo_data(
      TodoData apiObj, ffi.Pointer<wire_TodoData> wireObj) {
    _api_fill_to_wire_todo_data(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_box_autoadd_todo_event(
      TodoEvent apiObj, ffi.Pointer<wire_TodoEvent> wireObj) {
    _api_fill_to_wire_todo_event(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_box_autoadd_update_todo_request(
      UpdateTodoRequest apiObj, ffi.Pointer<wire_UpdateTodoRequest> wireObj) {
    _api_fill_to_wire_update_todo_request(apiObj, wireObj.ref);
  }

  void _api_fill_to_wire_create_todo_request(
      CreateTodoRequest apiObj, wire_CreateTodoRequest wireObj) {
    wireObj.label = _api2wire_String(apiObj.label);
  }

  void _api_fill_to_wire_log_message(
      LogMessage apiObj, wire_LogMessage wireObj) {
    wireObj.level = _api2wire_log_level(apiObj.level);
    wireObj.message = _api2wire_String(apiObj.message);
  }

  void _api_fill_to_wire_opt_box_autoadd_todo(
      Todo? apiObj, ffi.Pointer<wire_Todo> wireObj) {
    if (apiObj != null) _api_fill_to_wire_box_autoadd_todo(apiObj, wireObj);
  }

  void _api_fill_to_wire_opt_box_autoadd_todo_data(
      TodoData? apiObj, ffi.Pointer<wire_TodoData> wireObj) {
    if (apiObj != null)
      _api_fill_to_wire_box_autoadd_todo_data(apiObj, wireObj);
  }

  void _api_fill_to_wire_todo(Todo apiObj, wire_Todo wireObj) {
    wireObj.id = _api2wire_String(apiObj.id);
    wireObj.data = _api2wire_opt_box_autoadd_todo_data(apiObj.data);
  }

  void _api_fill_to_wire_todo_data(TodoData apiObj, wire_TodoData wireObj) {
    wireObj.label = _api2wire_String(apiObj.label);
    wireObj.status = _api2wire_status(apiObj.status);
    wireObj.created_at = _api2wire_String(apiObj.createdAt);
  }

  void _api_fill_to_wire_todo_event(TodoEvent apiObj, wire_TodoEvent wireObj) {
    wireObj.event_type = _api2wire_event_type(apiObj.eventType);
    wireObj.error_message = _api2wire_opt_String(apiObj.errorMessage);
    wireObj.data = _api2wire_opt_box_autoadd_todo(apiObj.data);
  }

  void _api_fill_to_wire_update_todo_request(
      UpdateTodoRequest apiObj, wire_UpdateTodoRequest wireObj) {
    wireObj.status = _api2wire_status(apiObj.status);
  }
}

// Section: wire2api
String _wire2api_String(dynamic raw) {
  return raw as String;
}

Todo _wire2api_box_autoadd_todo(dynamic raw) {
  return _wire2api_todo(raw);
}

TodoData _wire2api_box_autoadd_todo_data(dynamic raw) {
  return _wire2api_todo_data(raw);
}

EventType _wire2api_event_type(dynamic raw) {
  return EventType.values[raw];
}

List<Todo> _wire2api_list_todo(dynamic raw) {
  return (raw as List<dynamic>).map(_wire2api_todo).toList();
}

LogLevel _wire2api_log_level(dynamic raw) {
  return LogLevel.values[raw];
}

LogMessage _wire2api_log_message(dynamic raw) {
  final arr = raw as List<dynamic>;
  if (arr.length != 2)
    throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
  return LogMessage(
    level: _wire2api_log_level(arr[0]),
    message: _wire2api_String(arr[1]),
  );
}

String? _wire2api_opt_String(dynamic raw) {
  return raw == null ? null : _wire2api_String(raw);
}

Todo? _wire2api_opt_box_autoadd_todo(dynamic raw) {
  return raw == null ? null : _wire2api_box_autoadd_todo(raw);
}

TodoData? _wire2api_opt_box_autoadd_todo_data(dynamic raw) {
  return raw == null ? null : _wire2api_box_autoadd_todo_data(raw);
}

Status _wire2api_status(dynamic raw) {
  return Status.values[raw];
}

Todo _wire2api_todo(dynamic raw) {
  final arr = raw as List<dynamic>;
  if (arr.length != 2)
    throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
  return Todo(
    id: _wire2api_String(arr[0]),
    data: _wire2api_opt_box_autoadd_todo_data(arr[1]),
  );
}

TodoData _wire2api_todo_data(dynamic raw) {
  final arr = raw as List<dynamic>;
  if (arr.length != 3)
    throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
  return TodoData(
    label: _wire2api_String(arr[0]),
    status: _wire2api_status(arr[1]),
    createdAt: _wire2api_String(arr[2]),
  );
}

TodoEvent _wire2api_todo_event(dynamic raw) {
  final arr = raw as List<dynamic>;
  if (arr.length != 3)
    throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
  return TodoEvent(
    eventType: _wire2api_event_type(arr[0]),
    errorMessage: _wire2api_opt_String(arr[1]),
    data: _wire2api_opt_box_autoadd_todo(arr[2]),
  );
}

int _wire2api_u8(dynamic raw) {
  return raw as int;
}

Uint8List _wire2api_uint_8_list(dynamic raw) {
  return raw as Uint8List;
}

void _wire2api_unit(dynamic raw) {
  return;
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.

/// generated by flutter_rust_bridge
class TodoServicesWire implements FlutterRustBridgeWireBase {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  TodoServicesWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  TodoServicesWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void wire_dummy_todo_event(
    int port_,
    ffi.Pointer<wire_TodoEvent> todo_event,
  ) {
    return _wire_dummy_todo_event(
      port_,
      todo_event,
    );
  }

  late final _wire_dummy_todo_eventPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_TodoEvent>)>>('wire_dummy_todo_event');
  late final _wire_dummy_todo_event = _wire_dummy_todo_eventPtr
      .asFunction<void Function(int, ffi.Pointer<wire_TodoEvent>)>();

  void wire_dummy_log_message(
    int port_,
    ffi.Pointer<wire_LogMessage> log_message,
  ) {
    return _wire_dummy_log_message(
      port_,
      log_message,
    );
  }

  late final _wire_dummy_log_messagePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_LogMessage>)>>('wire_dummy_log_message');
  late final _wire_dummy_log_message = _wire_dummy_log_messagePtr
      .asFunction<void Function(int, ffi.Pointer<wire_LogMessage>)>();

  void wire_log_stream(
    int port_,
  ) {
    return _wire_log_stream(
      port_,
    );
  }

  late final _wire_log_streamPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_log_stream');
  late final _wire_log_stream =
      _wire_log_streamPtr.asFunction<void Function(int)>();

  void wire_load_app_config(
    int port_,
    ffi.Pointer<wire_uint_8_list> config,
  ) {
    return _wire_load_app_config(
      port_,
      config,
    );
  }

  late final _wire_load_app_configPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_uint_8_list>)>>('wire_load_app_config');
  late final _wire_load_app_config = _wire_load_app_configPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_todo_events(
    int port_,
  ) {
    return _wire_todo_events(
      port_,
    );
  }

  late final _wire_todo_eventsPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_todo_events');
  late final _wire_todo_events =
      _wire_todo_eventsPtr.asFunction<void Function(int)>();

  void wire_init_db(
    int port_,
  ) {
    return _wire_init_db(
      port_,
    );
  }

  late final _wire_init_dbPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>('wire_init_db');
  late final _wire_init_db = _wire_init_dbPtr.asFunction<void Function(int)>();

  void wire_create_todo(
    int port_,
    ffi.Pointer<wire_CreateTodoRequest> request,
  ) {
    return _wire_create_todo(
      port_,
      request,
    );
  }

  late final _wire_create_todoPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64,
              ffi.Pointer<wire_CreateTodoRequest>)>>('wire_create_todo');
  late final _wire_create_todo = _wire_create_todoPtr
      .asFunction<void Function(int, ffi.Pointer<wire_CreateTodoRequest>)>();

  void wire_update_todo(
    int port_,
    ffi.Pointer<wire_uint_8_list> id,
    ffi.Pointer<wire_UpdateTodoRequest> request,
  ) {
    return _wire_update_todo(
      port_,
      id,
      request,
    );
  }

  late final _wire_update_todoPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_UpdateTodoRequest>)>>('wire_update_todo');
  late final _wire_update_todo = _wire_update_todoPtr.asFunction<
      void Function(int, ffi.Pointer<wire_uint_8_list>,
          ffi.Pointer<wire_UpdateTodoRequest>)>();

  void wire_delete_todo(
    int port_,
    ffi.Pointer<wire_uint_8_list> id,
  ) {
    return _wire_delete_todo(
      port_,
      id,
    );
  }

  late final _wire_delete_todoPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64, ffi.Pointer<wire_uint_8_list>)>>('wire_delete_todo');
  late final _wire_delete_todo = _wire_delete_todoPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_get_all_todos(
    int port_,
  ) {
    return _wire_get_all_todos(
      port_,
    );
  }

  late final _wire_get_all_todosPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_get_all_todos');
  late final _wire_get_all_todos =
      _wire_get_all_todosPtr.asFunction<void Function(int)>();

  ffi.Pointer<wire_CreateTodoRequest> new_box_autoadd_create_todo_request() {
    return _new_box_autoadd_create_todo_request();
  }

  late final _new_box_autoadd_create_todo_requestPtr = _lookup<
          ffi.NativeFunction<ffi.Pointer<wire_CreateTodoRequest> Function()>>(
      'new_box_autoadd_create_todo_request');
  late final _new_box_autoadd_create_todo_request =
      _new_box_autoadd_create_todo_requestPtr
          .asFunction<ffi.Pointer<wire_CreateTodoRequest> Function()>();

  ffi.Pointer<wire_LogMessage> new_box_autoadd_log_message() {
    return _new_box_autoadd_log_message();
  }

  late final _new_box_autoadd_log_messagePtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_LogMessage> Function()>>(
          'new_box_autoadd_log_message');
  late final _new_box_autoadd_log_message = _new_box_autoadd_log_messagePtr
      .asFunction<ffi.Pointer<wire_LogMessage> Function()>();

  ffi.Pointer<wire_Todo> new_box_autoadd_todo() {
    return _new_box_autoadd_todo();
  }

  late final _new_box_autoadd_todoPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_Todo> Function()>>(
          'new_box_autoadd_todo');
  late final _new_box_autoadd_todo =
      _new_box_autoadd_todoPtr.asFunction<ffi.Pointer<wire_Todo> Function()>();

  ffi.Pointer<wire_TodoData> new_box_autoadd_todo_data() {
    return _new_box_autoadd_todo_data();
  }

  late final _new_box_autoadd_todo_dataPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_TodoData> Function()>>(
          'new_box_autoadd_todo_data');
  late final _new_box_autoadd_todo_data = _new_box_autoadd_todo_dataPtr
      .asFunction<ffi.Pointer<wire_TodoData> Function()>();

  ffi.Pointer<wire_TodoEvent> new_box_autoadd_todo_event() {
    return _new_box_autoadd_todo_event();
  }

  late final _new_box_autoadd_todo_eventPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<wire_TodoEvent> Function()>>(
          'new_box_autoadd_todo_event');
  late final _new_box_autoadd_todo_event = _new_box_autoadd_todo_eventPtr
      .asFunction<ffi.Pointer<wire_TodoEvent> Function()>();

  ffi.Pointer<wire_UpdateTodoRequest> new_box_autoadd_update_todo_request() {
    return _new_box_autoadd_update_todo_request();
  }

  late final _new_box_autoadd_update_todo_requestPtr = _lookup<
          ffi.NativeFunction<ffi.Pointer<wire_UpdateTodoRequest> Function()>>(
      'new_box_autoadd_update_todo_request');
  late final _new_box_autoadd_update_todo_request =
      _new_box_autoadd_update_todo_requestPtr
          .asFunction<ffi.Pointer<wire_UpdateTodoRequest> Function()>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list(
    int len,
  ) {
    return _new_uint_8_list(
      len,
    );
  }

  late final _new_uint_8_listPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_uint_8_list> Function(
              ffi.Int32)>>('new_uint_8_list');
  late final _new_uint_8_list = _new_uint_8_listPtr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void free_WireSyncReturnStruct(
    WireSyncReturnStruct val,
  ) {
    return _free_WireSyncReturnStruct(
      val,
    );
  }

  late final _free_WireSyncReturnStructPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturnStruct)>>(
          'free_WireSyncReturnStruct');
  late final _free_WireSyncReturnStruct = _free_WireSyncReturnStructPtr
      .asFunction<void Function(WireSyncReturnStruct)>();

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();
}

class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

class wire_TodoData extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> label;

  @ffi.Int32()
  external int status;

  external ffi.Pointer<wire_uint_8_list> created_at;
}

class wire_Todo extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> id;

  external ffi.Pointer<wire_TodoData> data;
}

class wire_TodoEvent extends ffi.Struct {
  @ffi.Int32()
  external int event_type;

  external ffi.Pointer<wire_uint_8_list> error_message;

  external ffi.Pointer<wire_Todo> data;
}

class wire_LogMessage extends ffi.Struct {
  @ffi.Int32()
  external int level;

  external ffi.Pointer<wire_uint_8_list> message;
}

class wire_CreateTodoRequest extends ffi.Struct {
  external ffi.Pointer<wire_uint_8_list> label;
}

class wire_UpdateTodoRequest extends ffi.Struct {
  @ffi.Int32()
  external int status;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<ffi.Uint8 Function(DartPort, ffi.Pointer<ffi.Void>)>>;
typedef DartPort = ffi.Int64;
