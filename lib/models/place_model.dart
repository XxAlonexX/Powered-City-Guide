class Place {
  final String id;
  final String name;
  final String category;
  final String description;
  final double rating;
  final String imageUrl;
  final String address;
  final List<String> tags;
  final double latitude;
  final double longitude;
  final bool isFavorite;
  final String location;
  final double price;

  Place({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.rating,
    required this.imageUrl,
    required this.address,
    required this.tags,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
    required this.location,
    required this.price,
  });

  Place copyWith({
    bool? isFavorite,
    String? location,
    double? price,
  }) {
    return Place(
      id: id,
      name: name,
      category: category,
      description: description,
      rating: rating,
      imageUrl: imageUrl,
      address: address,
      tags: tags,
      latitude: latitude,
      longitude: longitude,
      isFavorite: isFavorite ?? this.isFavorite,
      location: location ?? this.location,
      price: price ?? this.price,
    );
  }
}
