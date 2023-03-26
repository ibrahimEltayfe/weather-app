import 'dart:developer';
import 'package:geolocator/geolocator.dart';

import '../enums/geo_settings.dart';

class GEOService {
  static Future<Position> determinePosition({bool isForecast=false}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(
          [
            'Location services are disabled.',
            GEOSettings.openLocationSettings.name
          ]
      );
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error([
          'Location permissions are denied',
           GEOSettings.openAppSettings.name
        ]);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
            [
              'Location permissions are permanently denied, we cannot request permissions.',
               GEOSettings.openAppSettings.name
            ],

          );
    }

    if(isForecast){
      final lastKnownLocation = await Geolocator.getLastKnownPosition(forceAndroidLocationManager: false);
      log("lsl:"+lastKnownLocation.toString());
      if(lastKnownLocation!=null){
        return lastKnownLocation;
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy:LocationAccuracy.low,
      forceAndroidLocationManager:false,
    );
  }
}
