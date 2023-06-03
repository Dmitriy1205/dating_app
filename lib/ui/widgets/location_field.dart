import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

import 'field_decor.dart';

class LocationField extends StatefulWidget {
  final TextEditingController locationController;
  final double latitude;
  final double longitude;
  final Function(String) func;
  final String? language;

  const LocationField({
    Key? key,
    required this.locationController,
    required this.latitude,
    required this.longitude,
    required this.func,
    this.language,
  }) : super(key: key);

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  Position? _currentPosition;
  String address = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // enabled: false,
      keyboardType: TextInputType.none,
      controller: widget.locationController,
      onTap: () {
        _getCurrentPosition().then(
          (value) => showDialog(
              context: context,
              builder: (BuildContext c) {
                return AlertDialog(
                  content: SizedBox(
                    height: 400,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FlutterMap(
                          options: MapOptions(
                            center: _currentPosition != null
                                ? LatLng(
                                    _currentPosition!.latitude,
                                    _currentPosition!.longitude,
                                  )
                                : LatLng(
                                    widget.latitude,
                                    widget.longitude,
                                  ),
                            zoom: 5.3,
                            maxZoom: 17,
                            minZoom: 3.5,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: _currentPosition != null
                                      ? LatLng(
                                          _currentPosition!.latitude,
                                          _currentPosition!.longitude,
                                        )
                                      : LatLng(
                                          widget.latitude,
                                          widget.longitude,
                                        ),
                                  width: 10,
                                  height: 10,
                                  builder: (context) => const Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text(AppLocalizations.of(context)!.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        _getAddressFromLatLng(
                                lat: _currentPosition!.latitude,
                                lon: _currentPosition!.longitude,
                                lang: widget.language)
                            .then((value) => setState(() {
                                  address = value;
                                  widget.func(address);
                                  // widget.locationController.text = address;
                                }));

                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }),
        );
      },
      onSaved: (value) {
        widget.locationController.text = value!.trim();
      },
      decoration: locationFieldDecor(AppLocalizations.of(context)!.location),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    PermissionStatus androidPermission = await Permission.location.request();

    if (androidPermission.isDenied || androidPermission.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          content: Text(AppLocalizations.of(context)!.locationPermissionDenied),
        ),
      );
      return false;
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
     if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            content: Text(
              AppLocalizations.of(context)!.locationServicesAreDes,
            ),
          ),
        );
        return false;
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || androidPermission.isDenied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ) {
        if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            content:
                Text(AppLocalizations.of(context)!.locationPermissionDenied)));
        return false;}
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            content: Text(
                AppLocalizations.of(context)!.locationPermissionArePermanently)));
        return false;
      }

    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<String> _getAddressFromLatLng({
    required double lat,
    required double lon,
    String? lang,
  }) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(lat, lon, localeIdentifier: lang);
    return '${placemarks[0].locality}, ${placemarks[0].country}';
  }
}
