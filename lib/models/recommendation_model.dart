import 'place_model.dart';

class Recommendation {
  final String title;
  final List<Place> places;
  final String? description;

  Recommendation({
    required this.title,
    required this.places,
    this.description,
  });

  Recommendation copyWith({
    String? title,
    List<Place>? places,
    String? description,
  }) {
    return Recommendation(
      title: title ?? this.title,
      places: places ?? this.places,
      description: description ?? this.description,
    );
  }
}
