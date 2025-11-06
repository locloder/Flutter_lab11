import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(50.4501, 30.5234), // Київ
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps')),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (controller) {
          _controller = controller;
        },
        myLocationEnabled: true,
        markers: {
          const Marker(
            markerId: MarkerId('home'),
            position: LatLng(50.4501, 30.5234),
            infoWindow: InfoWindow(title: 'Київ'),
          ),
        },
      ),
    );
  }
}
