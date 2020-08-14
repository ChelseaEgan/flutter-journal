import 'package:flutter/material.dart';
import 'package:journal/db/journal_entry_dao.dart';
import 'package:journal/screens/journal_entry_view.dart';
import 'package:journal/screens/welcome.dart';
import 'package:intl/intl.dart';
import '../db/database_manager.dart';
import '../widgets/journal_scaffold.dart';
import '../models/journal.dart';
import '../models/journal_entry.dart';

class JournalEntries extends StatefulWidget {
  static const routeName = '/';

  @override
  _JournalEntriesState createState() => _JournalEntriesState();
}

class _JournalEntriesState extends State<JournalEntries> {
  Journal journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final databaseManager = DatabaseManager.getInstance();
    List<JournalEntry> journalEntries =
        await JournalEntryDAO.journalEntries(databaseManager: databaseManager);
    setState(() {
      journal = Journal(journalEntries: journalEntries ?? []);
    });
    print(journal.numberOfEntries);
  }

  @override
  Widget build(BuildContext context) {
    if (journal == null) {
      return JournalScaffold(
        title: 'Loading',
        hasFAB: true,
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return JournalScaffold(
          title: journal.isEmpty ? 'Welcome' : 'Journal Entries',
          hasFAB: true,
          child: journal.isEmpty
              ? Welcome()
              : LayoutBuilder(builder: layoutDecider));
    }
  }

  Widget layoutDecider(BuildContext context, BoxConstraints constraints) =>
      constraints.maxWidth >= 500
          ? masterDetailView(context, constraints)
          : journalList(context);

  Widget masterDetailView(BuildContext context, BoxConstraints constraints) =>
      Row(
        children: <Widget>[
          Container(
            child: journalList(context),
            width: constraints.maxWidth / 2,
          ),
          Container(
            child: JournalEntryView(entry: journal.journalEntries[0]),
            width: constraints.maxWidth / 2,
          ),
        ],
      );

  Widget journalList(BuildContext context) => ListView.builder(
      itemCount: journal.numberOfEntries,
      itemBuilder: (context, index) {
        return ListTile(
            leading: FlutterLogo(),
            trailing: Icon(Icons.more_horiz),
            title: Text('${journal.journalEntries[index].title}'),
            subtitle: Text(DateFormat('M/d/y H:m')
                .format(journal.journalEntries[index].date)),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => JournalEntryView(),
                  settings:
                      RouteSettings(arguments: journal.journalEntries[index]),
                )));
      });
}
