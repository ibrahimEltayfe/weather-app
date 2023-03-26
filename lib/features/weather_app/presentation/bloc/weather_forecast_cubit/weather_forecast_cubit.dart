import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_projects/error/failures.dart';
import 'package:my_projects/features/weather_app/domain/entities/five_day_forecast.dart';
import 'package:my_projects/features/weather_app/domain/use_cases/fiveday_forecast_usecase.dart';
import '../../../data/repositories/weather_repository_impl.dart';
part 'weather_forecast_state.dart';

class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  final WeatherRepositoryImpl weatherRepositoryImpl;
  final FiveDayForecastUseCase fiveDayForecastUseCase;
  WeatherForecastCubit(this.weatherRepositoryImpl, this.fiveDayForecastUseCase) : super(WeatherForecastInitial());

  Future getForecastWeather() async{
    emit(WeatherForecastLoading());

    final results = await fiveDayForecastUseCase();
    results.fold(
            (failure){
              if(failure is GeoPermissionFailure){
                emit(WeatherForecastError(message:failure.message,type: failure.errorIndex));
              } else{
                emit(WeatherForecastError(message:failure.message));
              }
            },

            (data) => emit(WeatherForecastDataFetched(data))
    );
  }
}
