import 'package:flutter/material.dart';
import 'package:journal/widgets/journal_entry_form.dart';

class NewEntry extends StatelessWidget {
  static const routeName = 'new-entry';

  @override
  Widget build(BuildContext context) {
    return JournalEntryForm();
  }
}
