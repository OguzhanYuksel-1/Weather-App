import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:havvadurumuuuu/screens/main_screen.dart';
import 'package:havvadurumuuuu/utils/location.dart';
import 'package:havvadurumuuuu/utils/weathear.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper _locationData;

  Future<void> getLocationData() async {
    _locationData = LocationHelper();
    await _locationData.getCurrentLocation();

    if (_locationData.latitude == null || _locationData.longitude == null) {
      // If location data is not found, print this error line
    } else {
      // Print latitude
      // Print longitude
    }
  }

  void getWeatherData() async { // Corrected method name
    await getLocationData();
    WeatherData weatherData = WeatherData(locationData: _locationData);
    await weatherData.getCurrentTemperature();
    if (weatherData.currentTemperature == null || weatherData.currentCondition == null) {
      // If temperature data is not obtained from the API, print this error line
    }

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    getWeatherData(); // Corrected method name
  }

  @override
  Widget build(BuildContext context) { // Loading screen code
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange, Colors.blue],
          ),
        ),
        child: const Center(
          child: SpinKitDancingSquare(
            color: Colors.white,
            size: 150.0,
            duration: Duration(milliseconds: 1200), // Corrected duration unit
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<LocationHelper>('locationData', _locationData));
  }
}
