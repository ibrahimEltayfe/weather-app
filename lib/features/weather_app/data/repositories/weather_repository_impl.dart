import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_projects/constants/app_errors.dart';
import 'package:my_projects/constants/end_points.dart';
import 'package:my_projects/error/failures.dart';
import 'package:my_projects/error/network_checker.dart';
import 'package:my_projects/features/weather_app/data/data_sources/weather_api.dart';
import 'package:my_projects/features/weather_app/data/models/air_pollution_model.dart';
import 'package:my_projects/features/weather_app/data/models/fiveday_weather_forecast_model.dart';
import 'package:my_projects/features/weather_app/data/models/current_weather_model.dart';
import 'package:my_projects/features/weather_app/domain/entities/air_pollution_entity.dart';
import 'package:my_projects/features/weather_app/domain/entities/five_day_forecast.dart';
import 'package:my_projects/features/weather_app/domain/entities/weather_entity.dart';
import 'package:my_projects/features/weather_app/domain/repositories/weather_repository.dart';
import 'package:my_projects/services/geo_service.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final NetworkInfo _connectionChecker;
  final WeatherAPI _weatherAPI;
  WeatherRepositoryImpl(this._connectionChecker, this._weatherAPI);

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather() async{
    return await _handleFailures<WeatherEntity>((lat,lon) async{
      Map<String,dynamic> data = await _weatherAPI.getData(endPointType: EndPoints.currentWeather,lat: lat, lon: lon, units: 'metric');
      return WeatherModel.fromJson(data);
    });
  }

  @override
  Future<Either<Failure, AirPollutionEntity>> getAirPollutionForecast()async {
    return await _handleFailures<AirPollutionEntity>((lat,lon) async{
      Map<String,dynamic> data = await _weatherAPI.getData(endPointType: EndPoints.airPollutionForecast,lat: lat, lon: lon);
      return AirPollutionModel.fromJson(data);
    });
  }

  @override
  Future<Either<Failure, AirPollutionEntity>> getCurrentAirPollution() async{
    return await _handleFailures<AirPollutionEntity>((lat,lon) async{
      Map<String,dynamic> data = await _weatherAPI.getData(endPointType: EndPoints.currentAirPollution,lat: lat, lon: lon);
      return AirPollutionModel.fromJson(data);
    });
  }

  @override
  Future<Either<Failure, FiveDayForecastEntity>> getFiveDayForecast() async{
    return await _handleFailures<FiveDayForecastEntity>((lat,lon) async{
      Map<String,dynamic> data = await _weatherAPI.getData(
          endPointType: EndPoints.fiveDayForecast,
          lat: lat,
          lon: lon,
          units: 'metric'
      );
      return FiveDayForecastModel.fromJson(data);
    },getLastKnownLocation : true);
  }

  @override
  Future<Either<Failure, AirPollutionEntity>> getHistoricalAirPollution({required String start, required String end}) async{
    return await _handleFailures<AirPollutionEntity>((lat,lon) async{
      Map<String,dynamic> data = await _weatherAPI.getData(endPointType: EndPoints.historicalAirPollution,lat: lat, lon: lon,start: start,end:end);
      return AirPollutionModel.fromJson(data);
    });
  }


  Future<Either<Failure, T>> _handleFailures<T>(Future<T> Function(String lat,String lon) task,{bool getLastKnownLocation = false}) async{

    if(await _connectionChecker.isConnected) {
      Position currentPosition;

      //gps - get lat and lon
      try{
        currentPosition = await GEOService.determinePosition(isForecast: getLastKnownLocation);

        log(currentPosition.longitude.toString());
      }catch(e){
        List error = e as List<String?>;
        String errorMsg = error[0];
        String? errorIndex = error[1];
        return Left(GeoPermissionFailure(errorMsg,errorIndex: errorIndex));
      }

      //get data from api
      try{
        T dataModel = await task(currentPosition.latitude.toString(),currentPosition.longitude.toString());
        return Right(dataModel);
      }catch(e){
        log(e.toString());
        return const Left(UnExpectedFailure(AppErrors.defaultError));
      }

    }else{
      return const Left(NoInternetFailure(AppErrors.noInternet));
    }
  }
}
