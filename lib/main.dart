import 'package:autask/app/app.dart';
import 'package:autask/app/di/injection.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const AutaskApp());
}
