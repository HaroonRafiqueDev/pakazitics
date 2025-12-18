import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/tourist_spot.dart';

class MapScreen extends StatefulWidget {
  final TouristSpot spot;

  const MapScreen({super.key, required this.spot});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  Position? _currentPosition;
  bool _isLoading = true;
  String? _error;
  double? _distance;
  String? _estimatedTime;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _error = 'Location permission denied';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _error = 'Location permissions are permanently denied';
          _isLoading = false;
        });
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Calculate distance
      final distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        widget.spot.latitude,
        widget.spot.longitude,
      );

      final distanceInKm = distanceInMeters / 1000;
      final estimatedMinutes = (distanceInKm / 40 * 60)
          .round(); // Assuming 40 km/h average

      setState(() {
        _currentPosition = position;
        _distance = distanceInKm;
        _estimatedTime = estimatedMinutes < 60
            ? '$estimatedMinutes minutes'
            : '${(estimatedMinutes / 60).toStringAsFixed(1)} hours';
        _isLoading = false;
      });

      // Fit bounds to show both markers
      // Removed _fitBounds() call here as it causes LateInitializationError
      // because the map is not yet built when this runs.
      // It will be called in onMapReady instead.
    } catch (e) {
      setState(() {
        _error = 'Failed to get location: $e';
        _isLoading = false;
      });
    }
  }

  void _fitBounds() {
    if (_currentPosition == null) return;

    final bounds = LatLngBounds(
      LatLng(
        _currentPosition!.latitude < widget.spot.latitude
            ? _currentPosition!.latitude
            : widget.spot.latitude,
        _currentPosition!.longitude < widget.spot.longitude
            ? _currentPosition!.longitude
            : widget.spot.longitude,
      ),
      LatLng(
        _currentPosition!.latitude > widget.spot.latitude
            ? _currentPosition!.latitude
            : widget.spot.latitude,
        _currentPosition!.longitude > widget.spot.longitude
            ? _currentPosition!.longitude
            : widget.spot.longitude,
      ),
    );

    // Add some padding
    final centerZoom = _mapController.centerZoomFitBounds(
      bounds,
      options: const FitBoundsOptions(padding: EdgeInsets.all(50)),
    );

    _mapController.move(centerZoom.center, centerZoom.zoom);
  }

  Future<void> _openInMaps() async {
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${widget.spot.latitude},${widget.spot.longitude}',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open maps')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.spot.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: _openInMaps,
            tooltip: 'Open in Google Maps',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_off, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _openInMaps,
                      icon: const Icon(Icons.map),
                      label: const Text('Open in Google Maps'),
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                // Flutter Map with OpenStreetMap
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    onMapReady: () {
                      if (_currentPosition != null) {
                        _fitBounds();
                      }
                    },
                    initialCenter: LatLng(
                      widget.spot.latitude,
                      widget.spot.longitude,
                    ),
                    initialZoom: 12.0,
                    minZoom: 5.0,
                    maxZoom: 18.0,
                  ),
                  children: [
                    // OpenStreetMap Tile Layer (No API key needed!)
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.pakazitics.app',
                      tileBuilder: (context, widget, tile) {
                        return ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade900.withOpacity(0.6)
                                : Colors.transparent,
                            BlendMode.darken,
                          ),
                          child: widget,
                        );
                      },
                    ),

                    // Markers Layer
                    MarkerLayer(
                      markers: [
                        // Destination marker (green)
                        Marker(
                          point: LatLng(
                            widget.spot.latitude,
                            widget.spot.longitude,
                          ),
                          width: 80,
                          height: 80,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  widget.spot.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                Icons.place,
                                color: Theme.of(context).primaryColor,
                                size: 40,
                              ),
                            ],
                          ),
                        ),

                        // Current location marker (blue)
                        if (_currentPosition != null)
                          Marker(
                            point: LatLng(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude,
                            ),
                            width: 80,
                            height: 80,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'You',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.my_location,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                // Info card
                if (_distance != null && _estimatedTime != null)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.spot.name,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildInfoItem(
                                    Icons.straighten,
                                    'Distance',
                                    '${_distance!.toStringAsFixed(1)} km',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildInfoItem(
                                    Icons.access_time,
                                    'Est. Time',
                                    _estimatedTime!,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _openInMaps,
                                icon: const Icon(Icons.directions),
                                label: const Text('Start Navigation'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // Zoom controls
                Positioned(
                  right: 16,
                  top: 16,
                  child: Column(
                    children: [
                      FloatingActionButton.small(
                        heroTag: 'zoom_in',
                        onPressed: () {
                          _mapController.move(
                            _mapController.camera.center,
                            _mapController.camera.zoom + 1,
                          );
                        },
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton.small(
                        heroTag: 'zoom_out',
                        onPressed: () {
                          _mapController.move(
                            _mapController.camera.center,
                            _mapController.camera.zoom - 1,
                          );
                        },
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(height: 8),
                      if (_currentPosition != null)
                        FloatingActionButton.small(
                          heroTag: 'fit_bounds',
                          onPressed: _fitBounds,
                          child: const Icon(Icons.fit_screen),
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Theme.of(context).primaryColor),
            const SizedBox(width: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
