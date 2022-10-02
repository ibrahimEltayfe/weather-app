import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_projects/error/failures.dart';
import 'package:my_projects/features/weather_app/domain/entities/weather_entity.dart';
import 'package:my_projects/services/geo_service.dart';
import '../../../data/repositories/weather_repository_impl.dart';
import '../../../domain/use_cases/current_weather_usecase.dart';
part 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  final WeatherRepositoryImpl weatherRepositoryImpl;
  final CurrentWeatherUseCase currentWeatherUseCase;
  CurrentWeatherCubit(this.weatherRepositoryImpl, this.currentWeatherUseCase) : super(CurrentWeatherInitial());

  Future getCurrentWeather() async{
    emit(CurrentWeatherLoading());

      final results = await currentWeatherUseCase();
      results.fold(
              (failure){
                if(failure is GeoPermissionFailure){
                  emit(CurrentWeatherError(message:failure.message,type: failure.errorIndex));
                }else{
                  emit(CurrentWeatherError(message:failure.message));
                }
              },

              (data)=>emit(CurrentWeatherDataFetched(data))

      );




  }

}
