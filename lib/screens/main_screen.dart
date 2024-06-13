import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havvadurumuuuu/utils/weathear.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;

  const MainScreen({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int temperature = 0;
  Icon weatherDisplayIcon =
      const Icon(FontAwesomeIcons.cloud); 
  AssetImage backroundImage = const AssetImage(
      "assets/bulutlu.jpeg"); 
  String city = "";

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature?.round() ?? 0;
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      city = weatherData.city ?? "";
      backroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                '$temperature°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                  letterSpacing: -5,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                city,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  letterSpacing: -5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
