import 'package:dio/dio.dart';
import 'package:floward_task/features/weather/data/models/weather_item_model.dart';
import 'package:floward_task/src/api/api_consumer.dart';
import 'package:floward_task/src/api/endpoints.dart';

abstract interface class WeatherRemoteDatasource {
  Future<WeatherItemModel> getWeather(String city);
}

class WeatherRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final ApiConsumer _consumer;

  WeatherRemoteDatasourceImpl(this._consumer);

  @override
  Future<WeatherItemModel> getWeather(String city) async {
    final Response response = await _consumer.getData(
        query: {'key': Endpoints.apiKey, 'q': city, 'aqi': 'no'},
        url: Endpoints.getCurrentWeatherCondition);

    return WeatherItemModel.fromJson(response.data);
  }
}
