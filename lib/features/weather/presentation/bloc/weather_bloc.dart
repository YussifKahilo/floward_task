import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/weather_item.dart';
import '../../domain/usecases/get_weather_condition_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherConditionUsecase _getWeatherConditionUsecase;

  WeatherBloc(this._getWeatherConditionUsecase) : super(WeatherInitial()) {
    on<CurrentWeatherRequestedEvent>(_getCurrentWeatherCondition);
  }

  static WeatherBloc get(context) => BlocProvider.of<WeatherBloc>(context);

  Future<void> _getCurrentWeatherCondition(
      CurrentWeatherRequestedEvent event, Emitter<WeatherState> emit) async {
    emit(GetCurrentWeatherConditionLoadingState());
    final result = await _getWeatherConditionUsecase(event.city);
    result.fold(
        (l) =>
            emit(GetCurrentWeatherConditionFailureState(l.message.toString())),
        (r) => emit(GetCurrentWeatherConditionSuccessState(r)));
  }
}
