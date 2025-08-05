import '../entities/weather_item.dart';

abstract interface class WeatherRepository {
  Future<WeatherItem> getWeather(String city);
}
