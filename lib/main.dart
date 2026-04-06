import 'package:autask/app/app.dart';
import 'package:autask/app/di/injection.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const AutaskApp());
}
