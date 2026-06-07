import 'package:expense_tracker/my_app.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.instance.initHive();
  runApp(const MyApp());
}
