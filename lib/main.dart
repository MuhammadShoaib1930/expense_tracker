import 'package:expense_tracker/services/hive_service.dart' show HiveService;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' show MobileAds;

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await HiveService.init();

  runApp(const MyApp());
}
