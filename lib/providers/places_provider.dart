import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class PlacesProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Place> _places = [];
  List<Place> _favoritePlaces = [];

  List<Place> get places => _places;
  List<Place> get favoritePlaces => _favoritePlaces;

  Future<void> fetchPlaces() async {
    try {
      final snapshot = await _firestore.collection('places').get();
      _places = snapshot.docs.map((doc) {
        final data = doc.data();
        return Place(
          id: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          category: data['category'] ?? '',
          location: data['location'] != null 
              ? LatLng(
                  data['location']['latitude'] ?? 0.0,
                  data['location']['longitude'] ?? 0.0,
                )
              : const LatLng(0, 0),
          address: data['address'] ?? '',
          rating: (data['rating'] ?? 0.0).toDouble(),
          images: List<String>.from(data['images'] ?? []),
          openingHours: Map<String, String>.from(data['openingHours'] ?? {}),
          contactNumber: data['contactNumber'] ?? '',
          website: data['website'] ?? '',
          priceLevel: data['priceLevel'] ?? 0,
          amenities: List<String>.from(data['amenities'] ?? []),
          reviews: [],
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching places: $e');
      // Handle error appropriately
    }
  }

  Future<List<Place>> searchPlaces(String query) async {
    try {
      final snapshot = await _firestore
          .collection('places')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + 'z')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Place(
          id: doc.id,
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          category: data['category'] ?? '',
          location: LatLng(
            data['location']['latitude'] ?? 0.0,
            data['location']['longitude'] ?? 0.0,
          ),
          address: data['address'] ?? '',
          rating: (data['rating'] ?? 0.0).toDouble(),
          images: List<String>.from(data['images'] ?? []),
          openingHours: Map<String, String>.from(data['openingHours'] ?? {}),
          contactNumber: data['contactNumber'] ?? '',
          website: data['website'] ?? '',
          priceLevel: data['priceLevel'] ?? 0,
          amenities: List<String>.from(data['amenities'] ?? []),
          reviews: [],
        );
      }).toList();
    } catch (e) {
      print('Error searching places: $e');
      return [];
    }
  }

  Future<void> addPlace(Place place) async {
    try {
      final docRef = await _firestore.collection('places').add({
        'name': place.name,
        'description': place.description,
        'category': place.category,
        'location': {
          'latitude': place.location.latitude,
          'longitude': place.location.longitude,
        },
        'address': place.address,
        'rating': place.rating,
        'images': place.images,
        'openingHours': place.openingHours,
        'contactNumber': place.contactNumber,
        'website': place.website,
        'priceLevel': place.priceLevel,
        'amenities': place.amenities,
      });
      
      final newPlace = place.copyWith(id: docRef.id);
      _places.add(newPlace);
      notifyListeners();
    } catch (e) {
      print('Error adding place: $e');
      // Handle error appropriately
    }
  }

  Future<void> addSamplePlaces() async {
    final samplePlaces = [
      Place(
        id: '',
        name: 'Central Park',
        description: 'A beautiful park in the heart of the city',
        category: 'Parks',
        location: const LatLng(40.785091, -73.968285),
        address: '123 Park Avenue',
        rating: 4.5,
        images: ['assets/images/image1.jpg', 'assets/images/image2.jpg'],
        openingHours: {'Monday': '6 AM - 10 PM', 'Tuesday': '6 AM - 10 PM'},
        contactNumber: '123-456-7890',
        website: 'www.centralpark.com',
        priceLevel: 1,
        amenities: ['Parking', 'Restrooms', 'Cafe'],
        reviews: [],
      ),
      Place(
        id: '',
        name: 'City Museum',
        description: 'Historic museum showcasing city artifacts',
        category: 'Museums',
        location: const LatLng(40.779437, -73.963244),
        address: '456 Museum Street',
        rating: 4.8,
        images: ['assets/images/image3.jpg', 'assets/images/image1.jpg'],
        openingHours: {'Monday': '9 AM - 5 PM', 'Tuesday': '9 AM - 5 PM'},
        contactNumber: '123-456-7891',
        website: 'www.citymuseum.com',
        priceLevel: 2,
        amenities: ['Gift Shop', 'Guided Tours', 'Cafe'],
        reviews: [],
      ),
    ];

    for (final place in samplePlaces) {
      await addPlace(place);
    }
  }

  void toggleFavorite(Place place) {
    if (_favoritePlaces.contains(place)) {
      _favoritePlaces.remove(place);
    } else {
      _favoritePlaces.add(place);
    }
    notifyListeners();
  }
}
