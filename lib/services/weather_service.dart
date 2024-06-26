import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:project_weather/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  static const BASE_URL_FORECAST =
      'https://api.openweathermap.org/data/2.5/forecast';
  final String api_KEY;

  WeatherService(this.api_KEY);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$api_KEY&units=metric'));

    if (response.statusCode != 200) {
      throw Exception('Error fetching weather data');
    } else {
      print(response.body);
      return Weather.fromJson(jsonDecode(response.body));
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String? cityName = placemarks[0].locality;

    return cityName ?? 'Unknown';
  }

  Future<List<Weather>> getForecastWeather(String lat, String lon) async {
    final response = await http.get(Uri.parse(
        '$BASE_URL_FORECAST?lat=$lat&lon=$lon&appid=$api_KEY&units=metric'));

    if (response.statusCode != 200) {
      throw Exception('Error fetching forecast weather data');
    } else {
      var forecastJson = jsonDecode(response.body);
      print('getForecastWeather: $forecastJson');
      List<dynamic> forecastList = forecastJson['list'];
      return forecastList
          .map((item) => Weather.fromForecastJson(item))
          .toList();
    }
  }
}
