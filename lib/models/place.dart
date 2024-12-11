import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Added import for Timestamp

class Place {
  final String id;
  final String name;
  final String description;
  final String category;
  final LatLng location;
  final String address;
  final double rating;
  final List<String> images;
  final Map<String, String> openingHours;
  final String contactNumber;
  final String website;
  final int priceLevel;
  final List<String> amenities;
  final List<Review> reviews;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.location,
    required this.address,
    required this.rating,
    required this.images,
    required this.openingHours,
    required this.contactNumber,
    required this.website,
    required this.priceLevel,
    required this.amenities,
    required this.reviews,
  });

  Place copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    LatLng? location,
    String? address,
    double? rating,
    List<String>? images,
    Map<String, String>? openingHours,
    String? contactNumber,
    String? website,
    int? priceLevel,
    List<String>? amenities,
    List<Review>? reviews,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      location: location ?? this.location,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      images: images ?? this.images,
      openingHours: openingHours ?? this.openingHours,
      contactNumber: contactNumber ?? this.contactNumber,
      website: website ?? this.website,
      priceLevel: priceLevel ?? this.priceLevel,
      amenities: amenities ?? this.amenities,
      reviews: reviews ?? this.reviews,
    );
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      location: LatLng(
        map['location']['latitude'] as double,
        map['location']['longitude'] as double,
      ),
      address: map['address'] as String,
      rating: map['rating'] as double,
      images: List<String>.from(map['images'] as List),
      openingHours: Map<String, String>.from(map['openingHours'] as Map),
      contactNumber: map['contactNumber'] as String,
      website: map['website'] as String,
      priceLevel: map['priceLevel'] as int,
      amenities: List<String>.from(map['amenities'] as List),
      reviews: (map['reviews'] as List)
          .map((review) => Review.fromMap(review as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
      'address': address,
      'rating': rating,
      'images': images,
      'openingHours': openingHours,
      'contactNumber': contactNumber,
      'website': website,
      'priceLevel': priceLevel,
      'amenities': amenities,
      'reviews': reviews.map((review) => review.toMap()).toList(),
    };
  }
}

class Review {
  final String id;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      rating: map['rating'] as double,
      comment: map['comment'] as String,
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }
}
