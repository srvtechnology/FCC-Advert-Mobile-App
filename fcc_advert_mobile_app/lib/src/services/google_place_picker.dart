import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:place_picker_google/place_picker_google.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;
class GooglePlacePickerExample extends StatefulWidget {
  const GooglePlacePickerExample({super.key});

  @override
  State<GooglePlacePickerExample> createState() =>
      _GooglePlacePickerExampleState();
}

class _GooglePlacePickerExampleState extends State<GooglePlacePickerExample> {
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showPlacePicker(); // 👈 Automatically open the picker
    });
  }

  @override
  Widget build(BuildContext context) {
    // Empty scaffold, since picker will open immediately
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()), // Optional loading
    );
  }

  void showPlacePicker() async {
    // Request permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        debugPrint("Location permissions are denied.");
        Navigator.of(context).pop(); // go back if permission denied
        return;
      }
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng currentLatLng = LatLng(position.latitude, position.longitude);

    // Navigate to PlacePicker with current location
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return PlacePicker(
            mapsBaseUrl: kIsWeb
                ? 'https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api/'
                : "https://maps.googleapis.com/maps/api/",
            usePinPointingSearch: true,
            apiKey: "AIzaSyB-ocv6g9BGI80S68ok6Cjjp2xvLqcLEs4",
            onPlacePicked: (LocationResult result) {
              debugPrint("Place picked: ${result.latLng}");
              Navigator.of(context).pop(result); // ✅ pass result back
            },
            enableNearbyPlaces: false,
            showSearchInput: true,
            initialLocation: currentLatLng,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller) {
              mapController = controller;
            },
            searchInputConfig: const SearchInputConfig(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              autofocus: false,
              textDirection: TextDirection.ltr,
            ),
            searchInputDecorationConfig: const SearchInputDecorationConfig(
              hintText: "Search for a building, street or ...",
            ),
            autocompletePlacesSearchRadius: 150,
          );
        },
      ),
    ).then((value) {
      Navigator.of(context).pop(value); // Return place to previous screen
    });
  }
}
