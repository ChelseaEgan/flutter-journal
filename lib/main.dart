import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal/state/theme_mode_provider.dart';
import 'db/database_manager.dart';
import 'app.dart';

const String title = 'Journal';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);
  await DatabaseManager.initialize();
  runApp(new ThemeModeProvider(child: App(title: title)));
}
