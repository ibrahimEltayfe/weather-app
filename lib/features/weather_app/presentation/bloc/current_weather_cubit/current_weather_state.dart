part of 'current_weather_cubit.dart';

abstract class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();
}

class CurrentWeatherInitial extends CurrentWeatherState {
  @override
  List<Object> get props => [];
}

class CurrentWeatherLoading extends CurrentWeatherState {
  @override
  List<Object> get props => [];
}

class CurrentWeatherDataFetched extends CurrentWeatherState{
  final WeatherEntity weatherData;
  const CurrentWeatherDataFetched(this.weatherData);

  @override
  List<Object> get props => [weatherData];
}

class CurrentWeatherError extends CurrentWeatherState {
  final String message;
  final String? type;
  const CurrentWeatherError({required this.message,this.type});

  @override
  List<Object> get props => [message];
}
