import 'package:project_weather/enums/weather_main_condition.dart';

class Weather {
  final String cityName;
  final double temperature;
  final WeatherMainCondition mainCondition;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'],
      mainCondition:
          WeatherMainConditionExtension.fromString(json['weather'][0]['main']),
    );
  }
}

extension WeatherMainConditionExtension on WeatherMainCondition {
  static WeatherMainCondition fromString(String condition) {
    switch (condition.toLowerCase()) {
      case 'thunderstorm':
        return WeatherMainCondition.Thunderstorm;
      case 'drizzle':
        return WeatherMainCondition.Drizzle;
      case 'rain':
        return WeatherMainCondition.Rain;
      case 'snow':
        return WeatherMainCondition.Snow;
      case 'clear':
        return WeatherMainCondition.Clear;
      case 'clouds':
        return WeatherMainCondition.Clouds;
      case 'mist':
        return WeatherMainCondition.Mist;
      default:
        return WeatherMainCondition.defaultCondition;
    }
  }
}
