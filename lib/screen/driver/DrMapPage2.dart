import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';

class DrMapPage2 extends StatefulWidget {
  const DrMapPage2({super.key});

  @override
  State<DrMapPage2> createState() => _LiveTrackingPageState();
}

class _LiveTrackingPageState extends State<DrMapPage2> {
  final MapController _mapController = MapController();
  final Location _location = Location();
  LatLng? _currentLocation;
  final TextEditingController _startPointController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final LatLng dhakaLocation = LatLng(23.8103, 90.4125);
  List<LatLng> routePoints = [];
  LatLng? startPoint;
  LatLng? endPoint;
  List<Map<String, dynamic>> searchResults = [];
  bool isSearching = false;

  void drawDirectRoute() {
    if (startPoint != null && endPoint != null) {
      setState(() {
        routePoints = [startPoint!, endPoint!];
        // Fit map bounds to show the entire route
        final bounds = LatLngBounds.fromPoints(routePoints);
        // ignore: deprecated_member_use
        _mapController.fitBounds(
          bounds,
          // ignore: deprecated_member_use
          options: const FitBoundsOptions(padding: EdgeInsets.all(50.0)),
        );
      });
    }
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
      return;
    }

    setState(() {
      isSearching = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5&country=bangladesh',
        ),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          searchResults = data.map<Map<String, dynamic>>((item) {
            return {
              'display_name': item['display_name'],
              'lat': double.parse(item['lat']),
              'lon': double.parse(item['lon']),
            };
          }).toList();
          isSearching = false;
        });
      }
    } catch (e) {
      errorMessage('Error searching location: $e');
      setState(() {
        isSearching = false;
      });
    }
  }

  void selectSearchResult(Map<String, dynamic> result) {
    setState(() {
      endPoint = LatLng(result['lat'], result['lon']);
      _destinationController.text = result['display_name'];
      searchResults = [];
    });
  }

  void errorMessage(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<bool> _checkRequestPermission() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }
    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<void> _initializeLocation() async {
    if (!await _checkRequestPermission()) return;
    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (mounted) {
        setState(() {
          _currentLocation =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
      }
    });
  }

  Future<void> jumptoCurrentLocation() async {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15);
    } else {
      errorMessage(
          'Please enable location services to see your current location.');
      await _initializeLocation();
    }
  }

  void _useCurrentLocationAsStart() {
    if (_currentLocation != null) {
      setState(() {
        startPoint = _currentLocation;
        _startPointController.text = 'Current Location';
      });
    } else {
      errorMessage('Current location not available');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: dhakaLocation,
              initialZoom: 12,
              minZoom: 0,
              maxZoom: 100,
              onTap: (tapPosition, point) {
                setState(() {
                  if (startPoint == null) {
                    startPoint = point;
                    _startPointController.text = 'Selected Location';
                  }
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.transport_system',
              ),
              if (routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routePoints,
                      color: Colors.yellow,
                      strokeWidth: 5.0,
                    ),
                  ],
                ),
              MarkerLayer(
                markers: [
                  if (_currentLocation != null)
                    Marker(
                      point: _currentLocation!,
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                  if (startPoint != null)
                    Marker(
                      point: startPoint!,
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.trip_origin,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),
                  if (endPoint != null)
                    Marker(
                      point: endPoint!,
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.place,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          controller: _startPointController,
                          decoration: const InputDecoration(
                            hintText:
                                'Choose starting point, or click on the map',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 0.5),
                          ),
                          readOnly: true,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.my_location),
                        onPressed: _useCurrentLocationAsStart,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _destinationController,
                              decoration: const InputDecoration(
                                hintText: 'Enter destination...',
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15),
                              ),
                              onChanged: (value) {
                                searchLocation(value);
                              },
                            ),
                          ),
                          if (_destinationController.text.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _destinationController.clear();
                                  searchResults = [];
                                  endPoint = null;
                                  routePoints = [];
                                });
                              },
                            ),
                        ],
                      ),
                      if (isSearching)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      if (searchResults.isNotEmpty)
                        Container(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              final result = searchResults[index];
                              return ListTile(
                                title: Text(
                                  result['display_name'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  selectSearchResult(result);
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (startPoint != null && endPoint != null) {
                            drawDirectRoute();
                          } else {
                            errorMessage(
                                'Please select both start and destination points');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Enter Route',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          startPoint = null;
                          endPoint = null;
                          routePoints = [];
                          _startPointController.clear();
                          _destinationController.clear();
                          searchResults = [];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(45, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.clear),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 119, 82, 223),
        foregroundColor: Colors.white,
        mini: true,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
              color: Color.fromARGB(255, 119, 82, 223), width: 2),
        ),
        onPressed: () {
          jumptoCurrentLocation();
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }

  @override
  void dispose() {
    _startPointController.dispose();
    _destinationController.dispose();
    super.dispose();
  }
}
