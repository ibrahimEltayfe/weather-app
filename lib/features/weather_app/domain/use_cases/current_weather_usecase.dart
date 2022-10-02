import 'package:dartz/dartz.dart';
import 'package:my_projects/error/failures.dart';
import 'package:my_projects/features/weather_app/domain/entities/weather_entity.dart';
import 'package:my_projects/features/weather_app/domain/repositories/weather_repository.dart';

class CurrentWeatherUseCase{
  final WeatherRepository _weatherRepository;
  CurrentWeatherUseCase(this._weatherRepository);

  Future<Either<Failure, WeatherEntity>> call() async{
    return _weatherRepository.getCurrentWeather();
  }
}