class TouristSpot {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final String bestTimeToVisit;
  final String entryFee;
  final double latitude;
  final double longitude;
  final String category;

  TouristSpot({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.bestTimeToVisit,
    required this.entryFee,
    required this.latitude,
    required this.longitude,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'bestTimeToVisit': bestTimeToVisit,
      'entryFee': entryFee,
      'latitude': latitude,
      'longitude': longitude,
      'category': category,
    };
  }

  factory TouristSpot.fromJson(Map<String, dynamic> json) {
    return TouristSpot(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imagePath: json['imagePath'],
      bestTimeToVisit: json['bestTimeToVisit'],
      entryFee: json['entryFee'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      category: json['category'],
    );
  }
}
