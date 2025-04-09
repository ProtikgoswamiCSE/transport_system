// ignore_for_file: unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class UrMapPage2 extends StatefulWidget {
  const UrMapPage2({super.key});

  @override
  State<UrMapPage2> createState() => _LiveTrackingPageState();
}

class _LiveTrackingPageState extends State<UrMapPage2> {
  final MapController _mapController = MapController();
  final Location _location = Location();
  LatLng? _currentLocation;

  Stream<LocationMarkerPosition> get _locationStream =>
      _location.onLocationChanged.map((locationData) => LocationMarkerPosition(
            latitude: locationData.latitude!,
            longitude: locationData.longitude!,
            accuracy: locationData.accuracy ?? 0.0,
          ));

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
      _mapController.move(_currentLocation!, 10);
    } else {
      errorMessage('Current location not available.');
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
              initialCenter: _currentLocation ?? const LatLng(23.6850, 90.3563),
              initialZoom: 3,
              minZoom: 0,
              maxZoom: 100,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.transport_system',
              ),
              CurrentLocationLayer(
                positionStream: _locationStream,
                style: const LocationMarkerStyle(
                  marker: DefaultLocationMarker(
                    child:
                        Icon(Icons.location_pin, color: Colors.white, size: 18),
                  ),
                  markerSize: Size(25, 25),
                  markerDirection: MarkerDirection.heading,
                ),
              ),
            ],
          )
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
}
