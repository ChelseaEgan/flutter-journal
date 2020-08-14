import 'package:flutter/material.dart';
import 'package:journal/screens/journal_entry_view.dart';
import 'package:journal/state/theme_mode_provider.dart';
import 'package:journal/screens/journal_entries.dart';
import 'screens/welcome.dart';
import 'screens/new_entry.dart';

class App extends StatefulWidget {
  final String title;

  const App({Key key, this.title}) : super(key: key);

  static final routes = {
    JournalEntries.routeName: (context) => new JournalEntries(),
    Welcome.routeName: (context) => Welcome(),
    NewEntry.routeName: (context) => NewEntry(),
    JournalEntryView.routeName: (context) => JournalEntryView(),
  };

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  ThemeMode theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setTheme();
  }

  @override
  Widget build(BuildContext context) {
    ThemeModeProvider.of(context).getIsDarkThemePreference();
    setTheme();

    return MaterialApp(
      title: widget.title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routes: App.routes,
      themeMode: theme,
    );
  }

  void setTheme() {
    setState(() {
      theme = ThemeModeProvider.of(context).isDarkTheme
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }
}
