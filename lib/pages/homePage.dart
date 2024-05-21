import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:project_weather/models/weather_model.dart';
import 'package:project_weather/services/weather_service.dart';
import 'package:project_weather/services/date-hours_service.dart'; // Import TimeService

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weatherService = WeatherService('8a9362a7e54eb6875172b74e6dc8a206');
  final _timeService = TimeService(); // Create an instance of TimeService
  Weather? _weather;
  String _cityTime = "";
  String _cityName = "";
  String _zoneTime = "Europe";

  _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeather(_cityName);
      final cityTime = await _timeService.getCityTime(
          _cityName, _zoneTime); // Use TimeService to get city time
      setState(() {
        _weather = weather;
        _cityTime = cityTime;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String mainCondition) {
    switch (mainCondition) {
      case 'Rain':
        return 'assets/cloud_rany.json';
      case 'Clouds':
        return 'assets/cloudy.json';
      case 'Clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          initialValue: _cityName,
          onFieldSubmitted: (value) {
            _fetchWeather();
          },
          onChanged: (value) {
            setState(() {
              _cityName = value;
            });
          },
          decoration: InputDecoration(
            hintText: "Enter city name",
            border: InputBorder.none,
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: _weather == null
            ? Text('Enter a city name and press search.')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_weather!.cityName ?? "Unknown"),
                  Lottie.asset(getWeatherAnimation(_weather!.mainCondition)),
                  Text('${_weather!.temperature.round()}°C'),
                  Text(_weather!.mainCondition ?? "Unknown"),
                  Text(_cityTime), // Display city time
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchWeather,
        tooltip: 'Fetch Weather',
        child: const Icon(Icons.search),
      ),
    );
  }
}
