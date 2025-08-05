import 'package:floward_task/features/weather/domain/entities/weather_item.dart';

class WeatherItemModel {
  final String city;
  final String temperature;
  final String condition;
  final String iconUrl;

  WeatherItemModel({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.iconUrl,
  });

  factory WeatherItemModel.fromJson(Map<String, dynamic> json) {
    return WeatherItemModel(
      city: json['location']['name'],
      temperature: json['current']['temp_c'].toString(),
      condition: json['current']['condition']['text'],
      iconUrl: 'https:${json['current']['condition']['icon']}',
    );
  }

  WeatherItem toEntity() {
    return WeatherItem(
      city: city,
      temperature: temperature,
      condition: condition,
      iconUrl: iconUrl,
    );
  }
}
