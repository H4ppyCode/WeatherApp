import 'package:project_weather/enums/weather_main_condition.dart';

class Weather {
  final String cityName;
  final double temperature;
  final WeatherMainCondition mainCondition;
  final DateTime? dateTime;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition,
      this.dateTime});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'],
      mainCondition:
          WeatherMainConditionExtension.fromString(json['weather'][0]['main']),
    );
  }

  factory Weather.fromForecastJson(Map<String, dynamic> json) {
    return Weather(
      cityName:
          "", // Le nom de la ville peut être ajouté séparément si nécessaire
      temperature: (json['main']['temp'] ?? 0.0).toDouble(),
      mainCondition: WeatherMainConditionExtension.fromString(
          json['weather'][0]['main'] ?? ""),
      dateTime: DateTime.parse(json['dt_txt'] ?? DateTime.now().toString()),
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
