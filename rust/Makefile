
# ##############################################################################
# # VARIABLES
# ##############################################################################

PROJECT_NAME=$(shell basename "$(PWD)")
PROJECT_LOCATION=$(shell dirname "$(PWD)")
SOURCES=$(sort $(wildcard ./src/*.rs ./src/**/*.rs))

RUST_LIB_NAME=todo
RUST_LIB_DIR_NAME=rust


GENERATED_FILE_PREFIX=bridge_generated

DART_GENERATED_FILE=todo_services_impl.dart
DART_GENERATED_DECL_FILE=todo_services.dart

RUST_API_LOCATION=$(PROJECT_LOCATION)/$(RUST_LIB_DIR_NAME)/src/api.rs
DART_GEN_DIR_LOCATION =$(PROJECT_LOCATION)/lib/api
DART_GEN_LOCATION=$(DART_GEN_DIR_LOCATION)/$(DART_GENERATED_FILE)
DART_GEN_DECL_LOCATION=$(DART_GEN_DIR_LOCATION)/$(DART_GENERATED_DECL_FILE)
IOS_H_GEN_LOCATION=$(PROJECT_LOCATION)/ios/Runner/$(GENERATED_FILE_PREFIX).h


FLUTTER_ANDROID_JNI_LIBS_LOCATION =../android/app/src/main/jniLibs
FLUTTER_IOS_RUNNER_LOCATION =../ios/Runner
FLUTTER_MACOS_RUNNER_AARCH64_LOCATION =../macos/Runner/aarch64
FLUTTER_MACOS_RUNNER_x86_64_LOCATION =../macos/Runner/x86_64

LLVM_PATH =/usr/local/opt/llvm/

# ##############################################################################
# # GOALS
# ##############################################################################

.DEFAULT_GOAL := help

.PHONY: help
help: Makefile
	@echo
	@echo " Available actions in "$(PROJECT_NAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

# ##############################################################################
# # INIT
# ##############################################################################

## add_target -> to add targets with rustup
.PHONY: add_target
add_target:
	rustup target add aarch64-linux-android armv7-linux-androideabi x86_64-linux-android i686-linux-android
	rustup target add aarch64-apple-ios x86_64-apple-ios

## install -> to install ffigen, cbidgen and flutter_rust_bridge_codegen
.PHONY: install
install:
	dart pub global activate ffigen
	cargo install cbindgen
	cargo install flutter_rust_bridge_codegen
	cargo install cargo-lipo


# ##############################################################################
# # CODE GEN
# ##############################################################################

## generate  -> to generate rust_flutter_bridge code
.PHONY: generate
generate:
	flutter_rust_bridge_codegen \
	--rust-input $(RUST_API_LOCATION) \
	--dart-output $(DART_GEN_LOCATION) \
	--c-output $(IOS_H_GEN_LOCATION) \
	--dart-decl-output $(DART_GEN_DECL_LOCATION) \
	--llvm-path $(LLVM_PATH)

# ##############################################################################
# # PLATFORMS COMPILE
# ##############################################################################

## android -> to compile for android platform
.PHONY: android
android: $(SOURCES) ndk-home
	cargo ndk -t armeabi-v7a -t arm64-v8a -t x86 -t x86_64 -o $(FLUTTER_ANDROID_JNI_LIBS_LOCATION) build

## ios -> to compile for ios platform
.PHONY: ios
ios:
	cargo lipo --targets aarch64-apple-ios,x86_64-apple-ios \
	&& cp target/universal/debug/lib$(RUST_LIB_NAME).a $(FLUTTER_IOS_RUNNER_LOCATION)

## macos -> to compile for macos platform
.PHONY: macos
macos:
	cargo lipo --targets x86_64-apple-darwin,aarch64-apple-darwin \
	&& mkdir ../macos/Runner/aarch64 \
	&& mkdir ../macos/Runner/x86_64 \
	&& cp target/aarch64-apple-darwin/debug/lib$(RUST_LIB_NAME).dylib $(FLUTTER_MACOS_RUNNER_AARCH64_LOCATION) \
	&& cp target/x86_64-apple-darwin/debug/lib$(RUST_LIB_NAME).dylib $(FLUTTER_MACOS_RUNNER_x86_64_LOCATION)

# ##############################################################################
# # SUMMARY
# ##############################################################################

## init -> to install dependencies and add targets
.PHONY: init
init: install add_target

## all -> to generate code and compile for all platforms
.PHONY: all
all: generate android ios macos


# ##############################################################################
# # UTILITIES
# ##############################################################################

## ndk_home -> to check ndk-home for android
.PHONY: ndk-home
ndk-home:
	@if [ ! -d "${ANDROID_NDK_HOME}" ] ; then \
		echo "Error: Please, set the ANDROID_NDK_HOME env variable to point to your NDK folder" ; \
		exit 1 ; \
	fi

# ##############################################################################
# # OTHER
# ##############################################################################

## clean -> to clean up
.PHONY: clean
clean:
	cargo clean
	rm -f target/bindings.h target/bindings.src.h

## test -> to test rust code
.PHONY: test
test:
	cargo test