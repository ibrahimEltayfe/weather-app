import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_projects/error/failures.dart';
import 'package:my_projects/features/weather_app/domain/entities/weather_entity.dart';
import '../../../../../constants/app_images.dart';
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

  String capitalize(String s, {bool allWords = false}) {
    if (s.isEmpty) {return '';}

    s = s.trim();
    if (allWords) {
      var words = s.split(' ');
      var capitalized = [];
      for (var w in words) {
        capitalized.add(capitalize(w));
      }
      return capitalized.join(' ');
    } else {
      return s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
    }
  }

  String getWeatherImage({required String main,int? clouds,required int dateTime,required int sunset,required int sunrise}){
    bool isNight = false;

    DateTime dt = DateTime.fromMillisecondsSinceEpoch(dateTime * 1000);
    DateTime ss = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
    DateTime sr = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    if(dt.isBefore(sr) || dt.isAfter(ss)){
      isNight = true;
    }

    switch(main.toLowerCase()){
      case 'clouds':
        if(clouds! >=11 || clouds <=25){
          return isNight? AppImages.fewCloudsNight : AppImages.fewClouds;
        }else{
          return AppImages.clouds;
        }

      case 'thunderstorm' : return AppImages.thunder;

      case 'Drizzle':
      case 'rain': return AppImages.rain;

      case 'snow': return AppImages.snow;

      case 'clear': return isNight ? AppImages.clearSkyNight : AppImages.clearSky;

      default: return AppImages.mist;


    }
  }


}
