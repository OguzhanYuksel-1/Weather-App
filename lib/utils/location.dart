import 'package:location/location.dart';

class LocationHelper {
  double? latitude; // Enlem
  double? longitude; // Boylam

  LocationHelper({this.latitude, this.longitude});

  Future<void> getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    // Location servisi etkin mi değilmi diye
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Kullanıcıdan konum izini almak için
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // izinler tamam ve servis ayakta ise bu kısım çalışıcak
    locationData = await location.getLocation();
    latitude = locationData.latitude;
    longitude = locationData.longitude;
  }
}
