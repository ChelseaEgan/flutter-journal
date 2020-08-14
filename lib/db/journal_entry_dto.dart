class JournalEntryDTO {
  String title;
  String body;
  String dateTime;
  int rating;
  String toString() {
    return 'Title: $title, Body: $body, Time: $dateTime, Rating: $rating';
  }
}
