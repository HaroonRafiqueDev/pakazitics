import 'package:flutter/material.dart';
import '../models/city.dart';
import '../services/data_service.dart';
import '../services/preferences_service.dart';

class AppProvider extends ChangeNotifier {
  final DataService _dataService = DataService();
  final PreferencesService _prefsService = PreferencesService();

  List<City> _cities = [];
  List<City> _filteredCities = [];
  bool _isDarkMode = false;
  bool _isLoading = true;
  String _selectedFilter = 'All';
  String _searchQuery = '';

  // Getters
  List<City> get cities => _cities;
  List<City> get filteredCities => _filteredCities;
  bool get isDarkMode => _isDarkMode;
  bool get isLoading => _isLoading;
  String get selectedFilter => _selectedFilter;
  String get searchQuery => _searchQuery;

  // Initialize
  Future<void> init() async {
    _cities = _dataService.getAllCities();
    _filteredCities = _cities;

    // Load theme preference
    _isDarkMode = await _prefsService.isDarkMode();

    _isLoading = false;
    notifyListeners();
  }

  // Theme Management
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _prefsService.setDarkMode(_isDarkMode);
    notifyListeners();
  }

  // Filter Management
  void filterCities(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setRatingFilter(String filter) {
    _selectedFilter = filter;
    _applyFilters();
  }

  void _applyFilters() {
    List<City> tempCities = _cities;

    // Apply Search
    if (_searchQuery.isNotEmpty) {
      tempCities = tempCities
          .where(
            (city) =>
                city.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                city.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    // Apply Rating Filter
    if (_selectedFilter == 'Top Rated') {
      tempCities = tempCities.where((city) => city.rating >= 4.5).toList();
    } else if (_selectedFilter == 'Popular') {
      tempCities = tempCities.where((city) => city.rating >= 4.0).toList();
    }

    _filteredCities = tempCities;
    notifyListeners();
  }
}
