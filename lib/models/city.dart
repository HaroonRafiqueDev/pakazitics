import 'tourist_spot.dart';

class City {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final double rating;
  final double latitude;
  final double longitude;
  final List<TouristSpot> touristSpots;

  City({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.touristSpots,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'rating': rating,
      'latitude': latitude,
      'longitude': longitude,
      'touristSpots': touristSpots.map((spot) => spot.toJson()).toList(),
    };
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imagePath: json['imagePath'],
      rating: json['rating'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      touristSpots: (json['touristSpots'] as List)
          .map((spot) => TouristSpot.fromJson(spot))
          .toList(),
    );
  }
}
