import 'package:flutter/material.dart';
import 'package:journal/state/theme_mode_provider.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 90.0,
          child: DrawerHeader(
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.headline6,
            ),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black))),
          ),
        ),
        SwitchListTile(
          title: Text('Dark mode'),
          value: ThemeModeProvider.of(context).isDarkTheme,
          onChanged: (value) =>
              ThemeModeProvider.of(context).setDarkTheme(value),
          secondary: const Icon(Icons.lightbulb_outline),
        )
      ],
    ));
  }
}
