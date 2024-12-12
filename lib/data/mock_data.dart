import '../models/place_model.dart';
import '../models/recommendation_model.dart';

class MockData {
  static final List<Place> popularPlaces = [
    Place(
      id: '1',
      name: 'Mountain Vista',
      category: 'Mountain',
      description: 'A breathtaking mountain landscape with panoramic views.',
      rating: 4.5,
      imageUrl: 'assets/images/mountain1.jpg',
      address: 'Alpine Range, Switzerland',
      tags: ['hiking', 'nature', 'scenic'],
      latitude: 46.6209,
      longitude: 8.0341,
      location: 'Swiss Alps',
      price: 18500.0,
      isFavorite: true,
    ),
    Place(
      id: '2',
      name: 'Waterfall Paradise',
      category: 'Waterfall',
      description: 'A stunning waterfall surrounded by lush green forest.',
      rating: 4.8,
      imageUrl: 'assets/images/waterfall1.jpg',
      address: 'Tropical Rainforest, Brazil',
      tags: ['water', 'nature', 'adventure'],
      latitude: -10.8305,
      longitude: -63.0919,
      location: 'Amazon Rainforest',
      price: 13500.0,
      isFavorite: false,
    ),
    Place(
      id: '3',
      name: 'Camping Retreat',
      category: 'Camping',
      description: 'A serene camping site nestled in the wilderness.',
      rating: 4.3,
      imageUrl: 'assets/images/camping1.jpg',
      address: 'National Forest, USA',
      tags: ['camping', 'outdoors', 'nature'],
      latitude: 44.0682,
      longitude: -121.3153,
      location: 'Oregon Wilderness',
      price: 9000.0,
      isFavorite: true,
    ),
    Place(
      id: '4',
      name: 'Coastal Escape',
      category: 'Beach',
      description: 'A picturesque beach with crystal clear waters.',
      rating: 4.7,
      imageUrl: 'assets/images/beach1.jpg',
      address: 'Tropical Coast, Thailand',
      tags: ['beach', 'relaxation', 'water'],
      latitude: 7.8804,
      longitude: 98.3923,
      location: 'Phuket Coast',
      price: 15000.0,
      isFavorite: false,
    ),
    Place(
      id: '5',
      name: 'Urban Adventure',
      category: 'City',
      description: 'Explore the vibrant streets and culture of a modern city.',
      rating: 4.6,
      imageUrl: 'assets/images/city1.jpg',
      address: 'Metropolitan Area, Japan',
      tags: ['city', 'culture', 'urban'],
      latitude: 35.6762,
      longitude: 139.6503,
      location: 'Tokyo City',
      price: 22500.0,
      isFavorite: true,
    ),
  ];

  static final List<Recommendation> recommendations = [
    Recommendation(
      title: 'Top Rated This Week',
      description: 'Most popular places based on user ratings',
      places: popularPlaces.sublist(0, 2),
    ),
    Recommendation(
      title: 'Family Friendly',
      description: 'Great spots for a family day out',
      places: popularPlaces.where((place) => place.tags.contains('nature')).toList(),
    ),
  ];

  static final List<String> categories = [
    'Mountain', 'Waterfall', 'Camping', 'Beach', 'City'
  ];
}
