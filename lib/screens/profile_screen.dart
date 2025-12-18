import 'package:flutter/material.dart';
import '../services/preferences_service.dart';
import '../services/data_service.dart';
import '../models/tourist_spot.dart';
import '../widgets/spot_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PreferencesService _prefsService = PreferencesService();
  final DataService _dataService = DataService();
  bool _isDarkMode = false;
  List<TouristSpot> _favoriteSpots = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final isDark = await _prefsService.isDarkMode();
    final favoriteIds = await _prefsService.getFavorites();

    final favorites = <TouristSpot>[];
    for (var id in favoriteIds) {
      final spot = _dataService.getSpotById(id);
      if (spot != null) {
        favorites.add(spot);
      }
    }

    if (mounted) {
      setState(() {
        _isDarkMode = isDark;
        _favoriteSpots = favorites;
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleTheme(bool value) async {
    await _prefsService.setDarkMode(value);
    setState(() {
      _isDarkMode = value;
    });

    // Notify parent to rebuild with new theme
    if (mounted) {
      // This will trigger a rebuild of the entire app
      // In a real app, you'd use a state management solution like Provider
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Theme changed to ${value ? 'Dark' : 'Light'} mode'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Restart App',
            onPressed: () {
              // In a real app, you'd restart or rebuild the app here
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        // Avatar
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Travel Enthusiast',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Exploring Pakistan\'s Beauty',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Settings Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Settings',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        // Theme Toggle
                        Card(
                          child: SwitchListTile(
                            title: const Text('Dark Mode'),
                            subtitle: const Text(
                              'Switch between light and dark theme',
                            ),
                            value: _isDarkMode,
                            onChanged: _toggleTheme,
                            secondary: Icon(
                              _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Favorites Section
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Favorite Spots',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_favoriteSpots.length} saved locations',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 16),

                        // Favorites List
                        _favoriteSpots.isEmpty
                            ? Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.favorite_border,
                                        size: 48,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No favorite spots yet',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(color: Colors.grey[600]),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Start exploring and save your favorite places!',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _favoriteSpots.length,
                                itemBuilder: (context, index) {
                                  return SpotCard(spot: _favoriteSpots[index]);
                                },
                              ),

                        const SizedBox(height: 24),

                        // App Info
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.info_outline,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  title: const Text('App Version'),
                                  subtitle: const Text('1.0.0'),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: Icon(
                                    Icons.location_on,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  title: const Text('Cities Available'),
                                  subtitle: Text(
                                    '${_dataService.getAllCities().length} cities',
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: Icon(
                                    Icons.place,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  title: const Text('Tourist Spots'),
                                  subtitle: Text(
                                    '${_dataService.getAllSpots().length} attractions',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
