import 'package:flutter/material.dart';
import 'journal_scaffold.dart';
import '../db/journal_entry_dto.dart';
import '../db/database_manager.dart';
import '../screens/journal_entries.dart';

class JournalEntryForm extends StatefulWidget {
  @override
  _JournalEntryFormState createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  final journalEntryFields = JournalEntryDTO();

  @override
  Widget build(BuildContext context) {
    return JournalScaffold(
        title: 'Add Journal Entry',
        hasFAB: false,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: form(context),
            ));
          },
        ));
  }

  Widget form(BuildContext context) => Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            textBox(context, 'Title', textValidator, titleSaveToDTO),
            SizedBox(height: 10),
            textBox(context, 'Journal Entry', textValidator, bodySaveToDTO),
            SizedBox(height: 10),
            textBox(context, 'Rating', ratingValidator, ratingSaveToDTO),
            SizedBox(height: 10),
            buttons(context),
          ],
        ),
      ));

  Widget textBox(BuildContext context, String title, Function validator,
          Function saveToDTO) =>
      TextFormField(
        autofocus: false,
        decoration:
            InputDecoration(labelText: title, border: OutlineInputBorder()),
        onSaved: (value) => saveToDTO(value),
        validator: (value) => validator(value),
      );

  Widget buttons(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          cancelButton(context),
          saveButton(context),
        ],
      );

  Widget cancelButton(BuildContext context) => RaisedButton(
      onPressed: () {
        formKey.currentState.reset();
        Navigator.of(context).pushNamed(JournalEntries.routeName);
      },
      child: Text('Cancel'));

  Widget saveButton(BuildContext context) => RaisedButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          journalEntryFields.dateTime = (new DateTime.now()).toString();
          final databaseManager = DatabaseManager.getInstance();
          databaseManager.saveJournalEntry(dto: journalEntryFields);
          formKey.currentState.reset();
          Navigator.of(context).pushNamed(JournalEntries.routeName);
        }
      },
      child: Text('Save Entry'));

  dynamic ratingValidator(String value) {
    if (int.tryParse(value) != null) {
      final intVal = int.parse(value);
      if (intVal >= 1 && intVal <= 4) {
        return null;
      }
    }
    return 'Please enter a rating of 1-4';
  }

  dynamic textValidator(String value) {
    return value.isEmpty ? 'Do not leave blank' : null;
  }

  void titleSaveToDTO(String value) {
    journalEntryFields.title = value;
  }

  void bodySaveToDTO(String value) {
    journalEntryFields.body = value;
  }

  void ratingSaveToDTO(String value) {
    journalEntryFields.rating = int.parse(value);
  }
}
