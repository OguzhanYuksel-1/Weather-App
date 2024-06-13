import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havvadurumuuuu/utils/location.dart';
import 'package:http/http.dart';

const apiKey = "863919b0ae72ee9e3634f1fcf6158d6a";

class WeatherDisplayData {
  final Icon weatherIcon;
  final AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  final LocationHelper _locationData;

  WeatherData({required LocationHelper locationData})
      : _locationData = locationData;

  double? currentTemperature;
  int? currentCondition;
  String? city;

  Future<void> getCurrentTemperature() async {
    try {
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${_locationData.latitude}&lon=${_locationData.longitude}&appid=$apiKey&units=metric"));

      if (response.statusCode == 200) {
        String data = response.body;
        var currentWeather = jsonDecode(data);

        currentTemperature =
            currentWeather['main']['temp'].toDouble(); // Sıcaklık
        currentCondition =
            currentWeather['weather'][0]['id']; // Hava durumu durumu
        city = currentWeather['name']; // Şehir
      } else {
      }
    // ignore: empty_catches
    } catch (e) {
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition != null && currentCondition! < 600) {
      return WeatherDisplayData(
        weatherIcon: const Icon(
          FontAwesomeIcons.cloud,
          size: 75.0,
          color: Colors.white,
        ),
        weatherImage: const AssetImage("assets/bulutlu.jpeg"),// hava bulutluysa bu kod satırları çalışıcak
      );
    } else {
      DateTime now = DateTime.now();
      if (now.hour >= 19) {
        return WeatherDisplayData(
          weatherIcon: const Icon(
            FontAwesomeIcons.moon,
            size: 75.0,
            color: Colors.white,
          ),
          weatherImage: const AssetImage("assets/gece.jpeg"),// geceyse bu kod satırları çalışıcak
        );
      } else {
        if (currentCondition == 800) {
          // Açık hava durumu
          return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.sun,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: const AssetImage("assets/gunesli.jpeg"),// güneşli ise bu kod satırları çalışıcak
          );
        } else if (currentCondition! >= 200 && currentCondition! < 300) {
          // Fırtına
          return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.wind,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: const AssetImage("assets/firtina.jpeg"),// fırtınalı ise bu kod satırları çalışıcak
          );
        } else if (currentCondition! >= 500 && currentCondition! < 600) {
          // Yağmurlu
          return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.cloudRain,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: const AssetImage("assets/yagmurlu.jpeg"),// yagmurlu ise bu kod satırları çalışıcak
          );
        } else if (currentCondition! >= 600 && currentCondition! < 700) {
          // Karlı
          return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.snowflake,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: const AssetImage("assets/karli.jpeg"),// karlı ise bu kod satırları çalışıcak
          );
        } else {
          return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.cloud,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: const AssetImage("assets/bulutlu.jpeg"),// bulutlu ise bu kod satırları çalışıcak
          );
        }
      }
    }
  }
}
