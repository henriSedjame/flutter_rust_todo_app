#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct wire_TodoData {
  struct wire_uint_8_list *label;
  int32_t status;
  struct wire_uint_8_list *created_at;
} wire_TodoData;

typedef struct wire_Todo {
  struct wire_uint_8_list *id;
  struct wire_TodoData *data;
} wire_Todo;

typedef struct wire_TodoEvent {
  int32_t event_type;
  struct wire_uint_8_list *error_message;
  struct wire_Todo *data;
} wire_TodoEvent;

typedef struct wire_LogMessage {
  int32_t level;
  struct wire_uint_8_list *message;
} wire_LogMessage;

typedef struct wire_CreateTodoRequest {
  struct wire_uint_8_list *label;
} wire_CreateTodoRequest;

typedef struct wire_UpdateTodoRequest {
  int32_t status;
} wire_UpdateTodoRequest;

typedef struct WireSyncReturnStruct {
  uint8_t *ptr;
  int32_t len;
  bool success;
} WireSyncReturnStruct;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

void wire_dummy_todo_event(int64_t port_, struct wire_TodoEvent *todo_event);

void wire_dummy_log_message(int64_t port_, struct wire_LogMessage *log_message);

void wire_log_stream(int64_t port_);

void wire_load_app_config(int64_t port_, struct wire_uint_8_list *config);

void wire_todo_events(int64_t port_);

void wire_init_db(int64_t port_);

void wire_create_todo(int64_t port_, struct wire_CreateTodoRequest *request);

void wire_update_todo(int64_t port_,
                      struct wire_uint_8_list *id,
                      struct wire_UpdateTodoRequest *request);

void wire_delete_todo(int64_t port_, struct wire_uint_8_list *id);

void wire_get_all_todos(int64_t port_);

struct wire_CreateTodoRequest *new_box_autoadd_create_todo_request(void);

struct wire_LogMessage *new_box_autoadd_log_message(void);

struct wire_Todo *new_box_autoadd_todo(void);

struct wire_TodoData *new_box_autoadd_todo_data(void);

struct wire_TodoEvent *new_box_autoadd_todo_event(void);

struct wire_UpdateTodoRequest *new_box_autoadd_update_todo_request(void);

struct wire_uint_8_list *new_uint_8_list(int32_t len);

void free_WireSyncReturnStruct(struct WireSyncReturnStruct val);

void store_dart_post_cobject(DartPostCObjectFnType ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_dummy_todo_event);
    dummy_var ^= ((int64_t) (void*) wire_dummy_log_message);
    dummy_var ^= ((int64_t) (void*) wire_log_stream);
    dummy_var ^= ((int64_t) (void*) wire_load_app_config);
    dummy_var ^= ((int64_t) (void*) wire_todo_events);
    dummy_var ^= ((int64_t) (void*) wire_init_db);
    dummy_var ^= ((int64_t) (void*) wire_create_todo);
    dummy_var ^= ((int64_t) (void*) wire_update_todo);
    dummy_var ^= ((int64_t) (void*) wire_delete_todo);
    dummy_var ^= ((int64_t) (void*) wire_get_all_todos);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_create_todo_request);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_log_message);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_todo);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_todo_data);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_todo_event);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_update_todo_request);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturnStruct);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}