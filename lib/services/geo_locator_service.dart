import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationService {
  Future<Map?> getLocationCoordinates() async {
    bool serviceEnabled;
    Map<String, dynamic> obj = {};

    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      obj['error'] = true;
      obj['msg'] =
          'Location services are disabled. PikiDelivery needs location to be enabled';

      return obj;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        obj['error'] = true;
        obj['msg'] =
            'Location permissions are denied PikiDelivery needs device location to work';
        return obj;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      obj['error'] = true;
      obj['msg'] =
          'Location permissions are permanently denied, PikiDelivery can not request permissions.';
      return obj;
    }

    Position position = await Geolocator.getCurrentPosition();
    return await coordinatesToAddress(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

//static Future <Map<String, dynamic>> coordinatesToAddress({latitude, longitude}) async
  Future coordinatesToAddress({latitude, longitude}) async {
    try {
      Map<String, dynamic> obj = {};
      List<Placemark> placemark =
          await placemarkFromCoordinates(latitude, longitude);

      String currentAddress =
          "${placemark.first.locality ?? ''} ${placemark.first.subLocality ?? ''} ${placemark.first.subAdministrativeArea ?? ''} ${placemark.first.country ?? ''}, ${placemark.first.postalCode ?? ''}";
      String country = placemark.first.country ?? '';

      obj['address'] = currentAddress;
      obj['error'] = false;
      obj['latitude'] = latitude;
      obj['longitude'] = longitude;
      obj['country'] = country;

      return obj;
    } catch (_) {
      print(_);
      return {};
    }
  }
}
