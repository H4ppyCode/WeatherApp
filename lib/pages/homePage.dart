import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_weather/enums/weather_main_condition.dart';
import 'package:project_weather/models/weather_model.dart';
import 'package:project_weather/services/timezone_service.dart';
import 'package:project_weather/services/weather_service.dart';
import 'package:project_weather/services/date-hours_service.dart'; // Import TimeService

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService =
      WeatherService('8a9362a7e54eb6875172b74e6dc8a206');
  final TimeService _timeService = TimeService();
  final TimezoneService _timezoneService = TimezoneService();

  Weather? _weather;
  String _cityTime = "";
  String _cityName = "";
  String _timeZone = "";
  String _errorMessage = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocationWeather();
  }

  Future<void> _fetchCurrentLocationWeather() async {
    try {
      final cityName = await _weatherService.getCurrentCity();
      setState(() {
        _cityName = cityName;
      });
      await _fetchWeather();
    } catch (e) {
      setState(() {
        _errorMessage = "Error fetching location.";
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchWeather() async {
    if (_cityName.isEmpty) {
      setState(() {
        _errorMessage = "Please enter a city name.";
        _isLoading = false;
      });
      return;
    }
    try {
      final weather = await _weatherService.getWeather(_cityName);
      final timezone = await _timezoneService.getCoordinates(_cityName);
      final cityTime = await _timeService.getCityTime(timezone);

      setState(() {
        _weather = weather;
        _cityTime = cityTime;
        _timeZone = timezone;
        _errorMessage = "";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Error fetching weather data.";
        _isLoading = false;
      });
    }
  }

  String _getWeatherAnimation(WeatherMainCondition mainCondition) {
    switch (mainCondition) {
      case WeatherMainCondition.Rain:
        return 'assets/cloud_rainy.json';
      case WeatherMainCondition.Clouds:
        return 'assets/cloudy.json';
      case WeatherMainCondition.Clear:
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
            setState(() {
              _cityName = value;
            });
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
      backgroundColor: Colors.white,
      body: Center(
        child: _isLoading
            ? Lottie.asset('assets/loader.json')
            : _weather == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_errorMessage.isNotEmpty)
                        Text(_errorMessage,
                            style: TextStyle(color: Colors.red)),
                      Text(
                          'Enter a city name and press search or wait for current location weather.'),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_weather!.cityName),
                      Lottie.asset(
                          _getWeatherAnimation(_weather!.mainCondition)),
                      Text('${_weather!.temperature.round()}°C'),
                      Text(_weather!.mainCondition.name),
                      SizedBox.fromSize(size: const Size(0, 20)),
                      Text(_cityTime),
                      Text(_timeZone),
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
