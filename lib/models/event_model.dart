class EventModel{
  String title;
  String location;
  String text;
  String date;
  String startTime;
  String endTime;
  String category;
  final String authorName;
  final int eventId = 0;
  final int userId = 0;
  final int id = 0;

  EventModel(this.title, this.location, this.text, this.date, this.startTime, this.endTime, this.category, this.authorName);
}