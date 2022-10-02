import 'package:dartz/dartz.dart';
import 'package:my_projects/error/failures.dart';
import 'package:my_projects/features/weather_app/domain/entities/air_pollution_entity.dart';
import 'package:my_projects/features/weather_app/domain/repositories/weather_repository.dart';

class HistoricalAirPollutionUseCase{
  final WeatherRepository _weatherRepository;
  HistoricalAirPollutionUseCase(this._weatherRepository);

  Future<Either<Failure, AirPollutionEntity>> call({required String start,required String end}) async{
    return _weatherRepository.getHistoricalAirPollution(end: end, start: start);
  }
}