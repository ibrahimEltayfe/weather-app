import 'package:dartz/dartz.dart';
import 'package:my_projects/error/failures.dart';
import 'package:my_projects/features/weather_app/domain/entities/air_pollution_entity.dart';
import 'package:my_projects/features/weather_app/domain/repositories/weather_repository.dart';

class CurrentAirPollutionUseCase{
  final WeatherRepository _weatherRepository;
  CurrentAirPollutionUseCase(this._weatherRepository);

  Future<Either<Failure, AirPollutionEntity>> call() async{
    return _weatherRepository.getCurrentAirPollution();
  }
}