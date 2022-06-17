import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/api/todo_services_impl.dart';
import 'package:todo_app/todo_page.dart';

final config_file_path = Platform.isIOS ? 'config/app_ios.yml' : 'config/app_android.yml';

const base = 'todo';
final path = Platform.isWindows
    ? '$base.dll'
    : (Platform.isMacOS ? 'lib$base.dylib' : 'lib$base.so');

final dylib =
    Platform.isIOS ? DynamicLibrary.process() : DynamicLibrary.open(path);

final api = TodoServicesImpl(dylib);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var config = await loadConfig();
  api.logStream().listen((event) {
    print("Receive log from rust :::: ${event.message}");
  });
  await api.loadAppConfig(config: config);
  await api.initDb();
  runApp(const MyApp());
}

// Load app config located in file config/app_android.yml
Future<String> loadConfig() async {
  return rootBundle.loadString("config/app.yml");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: TodoPage(todoServices: api),
    );
  }
}