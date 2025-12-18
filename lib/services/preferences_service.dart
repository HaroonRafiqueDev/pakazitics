import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;
  PreferencesService._internal();

  static const String _favoritesKey = 'favorite_spots';
  static const String _themeKey = 'is_dark_mode';

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Favorites
  Future<List<String>> getFavorites() async {
    final favorites = _prefs?.getStringList(_favoritesKey) ?? [];
    return favorites;
  }

  Future<void> addFavorite(String spotId) async {
    final favorites = await getFavorites();
    if (!favorites.contains(spotId)) {
      favorites.add(spotId);
      await _prefs?.setStringList(_favoritesKey, favorites);
    }
  }

  Future<void> removeFavorite(String spotId) async {
    final favorites = await getFavorites();
    favorites.remove(spotId);
    await _prefs?.setStringList(_favoritesKey, favorites);
  }

  Future<bool> isFavorite(String spotId) async {
    final favorites = await getFavorites();
    return favorites.contains(spotId);
  }

  // Theme
  Future<bool> isDarkMode() async {
    return _prefs?.getBool(_themeKey) ?? false;
  }

  Future<void> setDarkMode(bool isDark) async {
    await _prefs?.setBool(_themeKey, isDark);
  }

  // Get all preferences
  Future<UserPreferences> getUserPreferences() async {
    final favorites = await getFavorites();
    final isDark = await isDarkMode();
    return UserPreferences(favoriteSpotIds: favorites, isDarkMode: isDark);
  }
}
