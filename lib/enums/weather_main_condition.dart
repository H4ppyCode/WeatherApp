enum WeatherMainCondition {
  Thunderstorm,
  Drizzle,
  Rain,
  Snow,
  Clear,
  Clouds,
  defaultCondition;

  String get name {
    switch (this) {
      case WeatherMainCondition.Thunderstorm:
        return 'Thunderstorm';
      case WeatherMainCondition.Drizzle:
        return 'Drizzle';
      case WeatherMainCondition.Rain:
        return 'Rain';
      case WeatherMainCondition.Snow:
        return 'Snow';
      case WeatherMainCondition.Clear:
        return 'Clear';
      case WeatherMainCondition.Clouds:
        return 'Clouds';
      case WeatherMainCondition.defaultCondition:
        return 'defaultCondition';
    }
  }
}
