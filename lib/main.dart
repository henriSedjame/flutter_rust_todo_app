import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/api/todo_services_impl.dart';
import 'package:todo_app/todo_page.dart';

const base = 'todo';
final path = Platform.isWindows
    ? '$base.dll'
    : (Platform.isMacOS ? 'lib$base.dylib' : 'lib$base.so');

final dylib =
    Platform.isIOS ? DynamicLibrary.process() : DynamicLibrary.open(path);

final api = TodoServicesImpl(dylib);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  loadConfig().then((config) {
    api.loadAppConfig(config: config).then((_) {
      api.initDb().then((_) => runApp(const MyApp()));
    });
  });
}

// Load app config located in file config/app.yml
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