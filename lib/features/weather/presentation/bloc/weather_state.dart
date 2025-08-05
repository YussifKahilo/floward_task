part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class GetCurrentWeatherConditionLoadingState extends WeatherState {}

class GetCurrentWeatherConditionFailureState extends WeatherState {
  final String message;

  const GetCurrentWeatherConditionFailureState(this.message);
}

class GetCurrentWeatherConditionSuccessState extends WeatherState {
  final WeatherItem weatherItem;

  const GetCurrentWeatherConditionSuccessState(this.weatherItem);
}
