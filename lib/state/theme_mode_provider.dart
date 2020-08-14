import 'package:flutter/cupertino.dart';
import 'package:journal/models/theme_mode_preferences.dart';

class ThemeModeProvider extends StatefulWidget {
  final Widget child;

  const ThemeModeProvider({Key key, @required this.child}) : super(key: key);

  static _ThemeModeProviderState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ThemeModeInherited>())
        .data;
  }

  @override
  _ThemeModeProviderState createState() => _ThemeModeProviderState();
}

class _ThemeModeProviderState extends State<ThemeModeProvider> {
  ThemeModePreference themeModePreference = ThemeModePreference();
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void getIsDarkThemePreference() async {
    bool newTheme = await themeModePreference.getIsDarkMode();
    setState(() {
      _isDarkTheme = newTheme;
    });
  }

  void setDarkTheme(bool value) {
    themeModePreference.setIsDarkMode(value);
    setState(() {
      _isDarkTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeModeInherited(
      data: this,
      child: widget.child,
    );
  }
}

class ThemeModeInherited extends InheritedWidget {
  final _ThemeModeProviderState data;

  ThemeModeInherited({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(ThemeModeInherited oldWidget) => true;
}
