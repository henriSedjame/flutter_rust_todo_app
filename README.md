# TODO APP

## **_With Flutter and Rust FFI_**

This project is a _**proof of concept**_ to show how to use **Rust FFI** inside a **Flutter** application

We will use the  [flutter_rust_bridge](http://cjycode.com/flutter_rust_bridge/) library to achieve this.

Feel free to consult the library documentation [here](http://cjycode.com/flutter_rust_bridge/).


   ### 🏁 GET STARTED

<br>

<details>
    <summary>
       <strong>  STEP 1 : Create your flutter project </strong>
    </summary>

You can create your flutter project using flutter plugin of your preferred IDE, or use the following command

    flutter create --org <your.package.name> -i swift -a kotlin <your-app-name>

</details>

<br>

<details>
    <summary>
       <strong>  STEP 2 : Create your rust lib </strong>
    </summary>

Inside your flutter project directory, create your rust library using the following command:

    cargo new -lib --name <your-rust-lib-name>

</details>

<br>

<details>
    <summary>
       <strong>  STEP 3 : Create a Makefile </strong>
    </summary>

In order to list all the different commands that we will use in this project, we will create a makefile ⚠️ **_into the rust lib directory_**.

This makefile will look like this:

<details>
  <summary> Makefile </summary>



   
        # ##############################################################################
        # # VARIABLES
        # ##############################################################################
        
        PROJECT_NAME=$(shell basename "$(PWD)")
        PROJECT_LOCATION=$(shell dirname "$(PWD)")
        SOURCES=$(sort $(wildcard ./src/*.rs ./src/**/*.rs))
        
        RUST_LIB_NAME=todo
        RUST_LIB_DIR_NAME=rust
        RUST_INPUT_FILE=api.rs

        GENERATED_FILE_PREFIX=bridge_generated
        
        DART_GENERATED_FILE=todo_services_impl.dart
        DART_GENERATED_DECL_FILE =todo_services.dart
        
        RUST_API_LOCATION=$(PROJECT_LOCATION)/$(RUST_LIB_DIR_NAME)/src/$(RUST_INPUT_FILE)
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

</details>

**PS**: Change variables to match with your attempts !!! 😉

</details>

<br>

<details>
    <summary>
       <strong>  STEP 4 : Configure Rust Lib </strong>
    </summary>

In the rust library directory, update the **_cargo.toml_** file by adding the following lib section:

    [lib]
    name = "todo"
    crate-type = ["staticlib", "cdylib"]

We just need to add the library name and the crate types needed.

</details>

<br>

<details>
    <summary>
       <strong>  STEP 5 : Add dependencies </strong>
    </summary>


First we will add  **_flutter_rust_bridge_** dependency into the _pubspec.yaml_ file.

    flutter_rust_bridge: ^1.30.0

Then we will add some dependencies into the rust _cargo.toml_ file.

    anyhow = "1.0.52"

    flutter_rust_bridge = "1.30.0"

You can add additional dependencies. For this project, we will add some additional dependencies. 

Our cargo.toml file look like this:

    [package]
    name = "todo-services"
    version = "0.1.0"
    edition = "2021"
    
    # See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
    
    [lib]
    name = "todo"
    crate-type = ["staticlib", "cdylib"]
    
    [dependencies]
    
    ## Flutter rust bridge
    flutter_rust_bridge = "1.30.0"
    anyhow = "1.0.52"
    
    ## Handling global references
    lazy_static = "1.4.0"
    async_once = "0.2.6"
    once_cell = "1.12.0-pre.1"

    ## UUID generator
    uuid = { version="0.8.2" , features = ["default","v4"]}
    
    ## Handling Serialization
    serde = {version = "1.0.126", features= ["derive"] }
    serde_derive = "1.0.126"
    serde_json = "1.0.64"
    serde_yaml = "0.8.21"
    
    ## Data persistence
    mobc-postgres = {version = "0.7.0", features = ["with-chrono-0_4","with-serde_json-1","with-bit-vec-0_6"]}
    mobc = "0.7.3"
    postgres-types = { version = "0.2.2", features = ["derive"] }
    
    ## Asynchoronous
    tokio = {version = "1.8.0", features = ["macros", "fs", "rt"]}
    
    ## Handling error
    thiserror = "1.0.30"
    
    ## Handling Date
    chrono = { version = "0.4", features = ["unstable-locales"]}

</details>

<br>
<details>
    <summary> <strong>STEP 6: Add Rust code </strong></summary>

Create a rust file called as configure in **_Makefile_** variable **RUST_INPUT_FILE**

</details>

<br>
<details>
    <summary> <strong>STEP 7: Generate dart code </strong></summary>

In rust library directory, run :

    make init  \
    make generate \
    make ios \
    make android

In rust library directory, the file _**bridge_generated.rs_** will be generated.

In Flutter **ios/Runner** directory, two files will be generated:
 
- _**bridge_generated.h**_
- **_libtodo.a_**

In Flutter **android** directory a new directory _**/app/src/main/jniLibs**_ will be generated

In Flutter lib directory a new directory 

</details>

<br>
<details>
    <summary> <strong>STEP 8: Call rust code in flutter project</strong></summary>
</details>