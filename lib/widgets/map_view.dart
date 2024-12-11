import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../providers/places_provider.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocationProvider, PlacesProvider>(
      builder: (context, locationProvider, placesProvider, child) {
        final currentPosition = locationProvider.currentPosition;
        
        if (currentPosition == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final initialPosition = LatLng(
          currentPosition.latitude,
          currentPosition.longitude,
        );

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialPosition,
            zoom: 15,
          ),
          markers: locationProvider.markers,
          onMapCreated: (controller) {
            _mapController = controller;
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        );
      },
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
