part of 'weather_forecast_cubit.dart';

abstract class WeatherForecastState extends Equatable {
  const WeatherForecastState();
}

class WeatherForecastInitial extends WeatherForecastState {
  @override
  List<Object> get props => [];
}

class WeatherForecastLoading extends WeatherForecastState {
  @override
  List<Object> get props => [];
}

class WeatherForecastDataFetched extends WeatherForecastState {
  final FiveDayForecastEntity weatherData;
  const WeatherForecastDataFetched(this.weatherData);
  @override
  List<Object> get props => [weatherData];
}

class WeatherForecastError extends WeatherForecastState {
  final String message;
  final String? type;
  const WeatherForecastError({required this.message,this.type});

  @override
  List<Object> get props => [message];
}