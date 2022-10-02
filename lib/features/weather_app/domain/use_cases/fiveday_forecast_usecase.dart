import 'package:dartz/dartz.dart';
import 'package:my_projects/error/failures.dart';
import 'package:my_projects/features/weather_app/domain/entities/five_day_forecast.dart';
import 'package:my_projects/features/weather_app/domain/repositories/weather_repository.dart';

class FiveDayForecastUseCase{
  final WeatherRepository _weatherRepository;
  FiveDayForecastUseCase(this._weatherRepository);

  Future<Either<Failure, FiveDayForecastEntity>> call() async{
    return _weatherRepository.getFiveDayForecast();
  }
}