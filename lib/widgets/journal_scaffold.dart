import 'package:flutter/material.dart';
import 'package:journal/widgets/settings_drawer.dart';
import '../screens/new_entry.dart';

class JournalScaffold extends StatelessWidget {
  final String title;
  final bool hasFAB;
  final Widget child;

  const JournalScaffold({Key key, this.title, this.hasFAB, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: child,
      floatingActionButton: hasFAB ? addEntryFAB(context) : null,
      endDrawer: SettingsDrawer(),
    );
  }

  Widget addEntryFAB(BuildContext context) => FloatingActionButton(
        onPressed: () => navigateToForm(context),
        tooltip: 'Add journal entry',
        child: const Icon(Icons.add),
      );

  void navigateToForm(BuildContext context) =>
      Navigator.of(context).pushNamed(NewEntry.routeName);
}
