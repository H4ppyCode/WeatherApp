import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_weather/models/weather_model.dart';
import 'package:project_weather/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weatherService = WeatherService('8a9362a7e54eb6875172b74e6dc8a206');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String mainCondition) {
    switch (mainCondition) {
      case 'Rain':
        return 'assets/cloud_rainy.json';
      case 'Clouds':
        return 'assets/cloudy.json';
      case 'Clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Unknown"),
            Lottie.asset(getWeatherAnimation(_weather!.mainCondition)),
            Text('${_weather?.temperature.round()}°C'),
            Text(_weather?.mainCondition ?? "Unknown")
          ],
        ),
      ),
    );
  }
}
