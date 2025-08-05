import 'package:dio/dio.dart';
import 'package:floward_task/src/api/endpoints.dart';
import '/features/weather/data/datasources/weather_remote_datasource.dart';
import '/features/weather/data/repositories/weather_repository_impl.dart';
import '/features/weather/domain/repositories/weather_repository.dart';
import '/features/weather/domain/usecases/get_weather_condition_usecase.dart';
import 'package:get_it/get_it.dart';

import 'api/api_consumer.dart';
import 'api/dio_consumer.dart';
import 'api/handel_dio_error.dart';

final sl = GetIt.instance;

Future<void> initAppModule() async {
  //Src
  sl.registerFactory<Dio>(() => Dio());
  sl.registerFactory<ApiConsumer>(() => DioConsumer(
        dio: sl<Dio>(),
        handelDioError: handelDioError,
        baseUrl: Endpoints.baseUrl,
      ));
  _initWeatherModule();
}

void _initWeatherModule() {
  //Data source
  sl.registerFactory<WeatherRemoteDatasource>(
    () => WeatherRemoteDatasourceImpl(sl()),
  );

  //Repository
  sl.registerFactory<WeatherRepository>(
    () => WeatherRepositoryImpl(sl()),
  );

  //Usecases
  sl.registerFactory<GetWeatherConditionUsecase>(
    () => GetWeatherConditionUsecase(sl()),
  );
}
