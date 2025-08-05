import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:floward_task/features/weather/domain/entities/weather_item.dart';
import 'package:floward_task/features/weather/domain/repositories/weather_repository.dart';
import 'package:floward_task/src/errors/failure.dart';
import 'package:floward_task/src/usecases/base_usecase.dart';

class GetWeatherConditionUsecase extends BaseUseCase<WeatherItem, String> {
  final WeatherRepository _repository;

  GetWeatherConditionUsecase(this._repository);

  @override
  Future<Either<Failure, WeatherItem>> call(String params) async {
    try {
      final WeatherItem weatherItem = await _repository.getWeather(params);
      return Right(weatherItem);
    } catch (e, s) {
      Completer().completeError(e, s);
      return Left(Failure(e.toString()));
    }
  }
}
