class UserPreferences {
  final List<String> favoriteSpotIds;
  final bool isDarkMode;

  UserPreferences({required this.favoriteSpotIds, required this.isDarkMode});

  Map<String, dynamic> toJson() {
    return {'favoriteSpotIds': favoriteSpotIds, 'isDarkMode': isDarkMode};
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      favoriteSpotIds: List<String>.from(json['favoriteSpotIds'] ?? []),
      isDarkMode: json['isDarkMode'] ?? false,
    );
  }

  UserPreferences copyWith({List<String>? favoriteSpotIds, bool? isDarkMode}) {
    return UserPreferences(
      favoriteSpotIds: favoriteSpotIds ?? this.favoriteSpotIds,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
