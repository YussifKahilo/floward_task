import 'package:floward_task/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:floward_task/features/weather/domain/entities/weather_item.dart';

import '../../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource _datasource;

  WeatherRepositoryImpl(this._datasource);

  @override
  Future<WeatherItem> getWeather(String city) async {
    final weatherModel = await _datasource.getWeather(city);
    final WeatherItem weatherItem = weatherModel.toEntity();
    return weatherItem;
  }
}
