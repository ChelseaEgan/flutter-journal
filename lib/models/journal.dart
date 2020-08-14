import 'package:journal/models/journal_entry.dart';

class Journal {
  List<JournalEntry> _journalEntries;

  Journal({List<JournalEntry> journalEntries})
      : _journalEntries = journalEntries ?? [];

  void addJournalEntry(JournalEntry entry) {
    _journalEntries.add(entry);
  }

  bool get isEmpty => _journalEntries.length == 0;

  int get numberOfEntries => _journalEntries.length;

  List<JournalEntry> get journalEntries => _journalEntries;
}
