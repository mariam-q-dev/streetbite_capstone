import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VendorMapScreen extends StatefulWidget {
  const VendorMapScreen({super.key});

  @override
  State<VendorMapScreen> createState() => _VendorMapScreenState();
}

class _VendorMapScreenState extends State<VendorMapScreen> {
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(30.0444, 31.2357), // القاهرة أو المنصورة افتراضياً
    zoom: 12,
  );

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('vendor_1'),
      position: LatLng(30.0500, 31.2333),
      infoWindow: InfoWindow(title: 'Street Grill', snippet: 'BBQ & Burgers · Rating: 4.8'),
    ),
    const Marker(
      markerId: MarkerId('vendor_2'),
      position: LatLng(30.0400, 31.2400),
      infoWindow: InfoWindow(title: 'Cairo Koshary', snippet: 'Traditional · Rating: 4.9'),
    ),
    const Marker(
      markerId: MarkerId('vendor_3'),
      position: LatLng(30.0600, 31.2200),
      infoWindow: InfoWindow(title: 'Nile Crepe', snippet: 'Fast Food · Rating: 4.6'),
    ),
    const Marker(
      markerId: MarkerId('vendor_4'),
      position: LatLng(30.0300, 31.2500),
      infoWindow: InfoWindow(title: 'Alex Falafel', snippet: 'Street Breakfast · Rating: 4.7'),
    ),
    const Marker(
      markerId: MarkerId('vendor_5'),
      position: LatLng(30.0550, 31.2450),
      infoWindow: InfoWindow(title: 'Spicy Shawarma', snippet: 'Wraps & Grills · Rating: 4.9'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Vendors')),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        markers: _markers,
        myLocationEnabled: true,
      ),
    );
  }
}