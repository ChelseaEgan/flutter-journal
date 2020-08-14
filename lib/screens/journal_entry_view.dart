import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal/models/journal_entry.dart';
import 'package:journal/widgets/journal_scaffold.dart';

class JournalEntryView extends StatelessWidget {
  static const routeName = 'journal-entry';
  final JournalEntry entry;

  JournalEntryView({Key key, this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JournalEntry journalEntry =
        ModalRoute.of(context).settings.arguments ?? this.entry;

    return JournalScaffold(
      title: DateFormat('MMMM d, y').format(journalEntry.date),
      hasFAB: false,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            minWidth: constraints.maxWidth,
          ),
          child: displayEntry(context, journalEntry),
        ));
      }),
    );
  }

  Widget displayEntry(BuildContext context, JournalEntry journalEntry) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                journalEntry.title,
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 10.0),
              Text(
                journalEntry.body,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 10.0),
              Text(
                'Rating: ${journalEntry.rating.toString()}',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      );
}
