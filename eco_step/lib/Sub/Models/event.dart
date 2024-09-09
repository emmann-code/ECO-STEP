// event_model.dart

class EventModel {
  final String title;
  final String date;
  final String organizer;
  final String image;

  EventModel({
    required this.title,
    required this.date,
    required this.organizer,
    required this.image,
  });
}

// Example usage:
final List<EventModel> events = [
  EventModel(
    title: 'Plastic-free on the Chalk Lakes',
    date: '16.06.24',
    organizer: 'Cleaners Inc.',
    image: 'assets/browncarouselback.png',
  ),
  EventModel(
    title: 'Another Event',
    date: '18.07.24',
    organizer: 'Event Co.',
    image: 'assets/greycarouselsbackpic.png',
  ),
  // Add more events here
];
