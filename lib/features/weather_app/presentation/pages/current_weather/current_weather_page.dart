import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:lottie/lottie.dart';
import 'package:my_projects/constants/app_colors.dart';
import 'package:my_projects/constants/app_constants.dart';
import 'package:my_projects/constants/app_images.dart';
import 'package:my_projects/constants/end_points.dart';
import 'package:my_projects/features/weather_app/domain/entities/weather_entity.dart';
import 'package:my_projects/features/weather_app/presentation/bloc/current_weather_cubit/current_weather_cubit.dart';
import 'package:my_projects/features/weather_app/presentation/bloc/weather_forecast_cubit/weather_forecast_cubit.dart';
import 'package:my_projects/features/weather_app/presentation/widgets/modal_bottom_sheet.dart';
import 'package:my_projects/reusable_components/custom_drawer.dart';
import 'package:weather_icons/weather_icons.dart' show WeatherIcons,BoxedIcon;

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
          bottomSheet: const CustomModalBottomSheet(),
          drawerEnableOpenDragGesture: true,
          drawer: const CustomDrawer(),
          body: RefreshIndicator(

            onRefresh:() async{
              context.read<CurrentWeatherCubit>().getCurrentWeather();
              if(context.read<CurrentWeatherCubit>().state is CurrentWeatherDataFetched){
                context.read<WeatherForecastCubit>().getForecastWeather();
              }

            },
            child: SafeArea(
              child: Builder(
                builder: (context) =>
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child:BlocBuilder<CurrentWeatherCubit,CurrentWeatherState>(
                          builder: (context,state) {
                            if(state is CurrentWeatherLoading){
                              return _buildLoadingWidget(context);
                            }else if(state is CurrentWeatherError){
                              return _buildErrorWidget(state, theme.textTheme.headline1!,context);
                            }else if(state is CurrentWeatherDataFetched){
                              WeatherEntity data = state.weatherData;
                              //log(data.weather![0].main!.toString());
                              return Column(
                                children: [
                                  SizedBox(height: 22,),

                                  //city
                                  Center(
                                    child: Text(
                                        '${data.cityName}/${data.sys!.country}',
                                        style: theme.textTheme.headline1!.copyWith(fontSize:28 )
                                    ),
                                  ),

                                  //page state
                                  Text(
                                      'now',
                                      style: theme.textTheme.headline1!.copyWith(color: AppColors.grey,fontSize: 22)
                                  ),

                                  SizedBox(height: 21,),

                                  //image
                                  SvgPicture.asset(
                                    chooseImage(
                                        main: data.weather![0].main!,
                                        dateTime: data.dt!,
                                        sunset: data.sys!.sunset!,
                                        sunrise: data.sys!.sunrise!,
                                        clouds: data.clouds!.all!
                                    ),
                                    width: 105,
                                    height: 105,
                                  ),

                                  SizedBox(height: 21,),

                                  //temp
                                  Text(
                                      '${data.main!.temp!}',
                                      style: theme.textTheme.headline1!.copyWith(fontFamily: 'bahnsch', fontSize: 48,)
                                  ),

                                  SizedBox(height: 8,),

                                  //desc
                                  Text(
                                    capitalize('${data.weather![0].description}'),
                                    style:theme.textTheme.headline1!.copyWith(fontSize: 28) ,
                                  ),

                                  SizedBox(height: 24,),

                                  //additional info`s
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      additionalInfo(
                                        icon: FontAwesomeIcons.wind,
                                        text: '${data.wind!.speed}m/s',
                                        textStyle: theme.textTheme.headline1!.copyWith(fontSize: 20),
                                      ),
                                      additionalInfo(
                                        weatherIcon: WeatherIcons.humidity,
                                        text:'${data.main!.humidity!}%',
                                        textStyle: theme.textTheme.headline1!.copyWith(fontSize: 20),
                                      ),
                                      additionalInfo(
                                        icon: FontAwesomeIcons.cloud,
                                        text:'${data.clouds!.all}%',
                                        textStyle: theme.textTheme.headline1!.copyWith(fontSize: 20),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 55,),

                                  //forecast
                                  Align(
                                    alignment: Alignment(-0.75,0.0),
                                    child: Text(
                                      'Weather Forecast',
                                      style: theme.textTheme.headline1!.copyWith(fontSize: 25),
                                    ),
                                  ),

                                  SizedBox(height: 14,),

                                  BlocBuilder<WeatherForecastCubit,WeatherForecastState>(
                                    builder: (context, state) {
                                      if(state is WeatherForecastLoading){
                                        return Center(child: Text('loading'),);
                                      }else if(state is WeatherForecastError){
                                        return Center(child: Text(state.message),);
                                      }else if(state is WeatherForecastDataFetched){
                                        /*List<Temps> tempsData = getCurrentDayForecast(data.dt!, state.weatherData);
                                        if(tempsData.isEmpty){
                                          return Center(child: Text("no forecast data for today,it is the end of the day.."),);
                                        }*/
                                        return Column(
                                          children: List.generate(5, (index) =>
                                              _buildForecastData(
                                                  date: DateFormat('EEE, h:mm a').format(DateTime.fromMillisecondsSinceEpoch(
                                                      state.weatherData.temps![index].dt!*1000)
                                                  ),
                                                  icon: '${EndPoints.networkIcon}${state.weatherData.temps![index].weather![0].icon!}.png',
                                                  temp: state.weatherData.temps![index].main!.temp! as double,
                                                  textStyle: theme.textTheme.headline2!.copyWith(fontSize: 21),
                                                  context: context
                                              ),
                                          ),
                                        );
                                      }

                                      return const SizedBox.shrink();
                                    },

                                  ),

                                  SizedBox(height: 12,),

                                ],);
                            }else{
                              return const SizedBox.shrink();
                            }
                          }
                      ),
                    ),
              ),
            ),
          )
      );
}

  String chooseImage({required String main,int? clouds,required int dateTime,required int sunset,required int sunrise}){
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

  Widget additionalInfo({
    IconData? icon,
    required String text,
    IconData? weatherIcon,
    required TextStyle textStyle
  }){
    return SizedBox(
      height: 35,
      child: Row(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisSize: MainAxisSize.min,

        children: [
          weatherIcon!=null
          ?SizedBox(
            width:19,
            height: 25,
            child: FittedBox(
                fit: BoxFit.cover,
                child:BoxedIcon(weatherIcon,)
            ),
          )
          :Icon(icon,size: 18,),

          SizedBox(width: 12,),

          Text(text,style: textStyle,)
        ],
      ),
    );
  }

  /*List<Temps> getCurrentDayForecast(int currentWeatherDate,FiveDayForecastEntity fiveDayForecast){
    List<Temps> tempsData=[];
    DateTime currentDT = DateTime.fromMillisecondsSinceEpoch(currentWeatherDate*1000);

    for(int i=0; i<fiveDayForecast.temps!.length;i++){
      DateTime forecastDT = DateTime.fromMillisecondsSinceEpoch(fiveDayForecast.temps![i].dt! *1000);
      if(forecastDT.day == currentDT.day){
        tempsData.add(fiveDayForecast.temps![i]);
      }else{
        break;
      }
    }

    return tempsData;
  }*/

  Widget _buildForecastData({
    required String date,
    required double temp,
    required String icon,
    required TextStyle textStyle,
    required BuildContext context
  }){
    return SizedBox(
      width:  MediaQuery.of(context).size.width*0.95,
      height: 38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(date,style: textStyle,)
            )
          ),

          Flexible(child: Image.network(icon,width: 32,height: 32,)),
          //Icon(icon,size: 19.sp,),
          SizedBox(
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('${temp.toStringAsFixed(1)}°',style: textStyle,)
              )
          )
        ],
      ),
    );
  }

  _buildLoadingWidget(BuildContext context){
    return Container(
      height:  MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Lottie.asset('assets/lottie/wind.json',width:  MediaQuery.of(context).size.height*0.6,height:  MediaQuery.of(context).size.height*0.4,fit: BoxFit.contain),
    );
  }

  _buildErrorWidget(CurrentWeatherError state,TextStyle txtStyle,BuildContext context){
    if(state.type == null){
      return Container(
          height:  MediaQuery.of(context).size.height*0.95,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                  'assets/lottie/winter error.json',
                  width:  MediaQuery.of(context).size.width*0.5,
                  height:  MediaQuery.of(context).size.height*0.3,
                  fit: BoxFit.contain
              ),
              Text(state.message,style: txtStyle,)
            ],
          )
      );
    }else{
      bool isLocationSettings = state.type == GEOSettings.openLocationSettings.name;
      return SizedBox(
        width:  MediaQuery.of(context).size.width,
        height:  MediaQuery.of(context).size.height*0.95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.message,style: txtStyle.copyWith(fontSize: 20)),

            SizedBox(height: 14,),

            ElevatedButton(
              style:ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                   Size( MediaQuery.of(context).size.width*0.45, MediaQuery.of(context).size.height*0.07)
                )
              ) ,
              onPressed: () async{
              if(isLocationSettings){
                await Geolocator.openLocationSettings();
              }else{
                await Geolocator.openAppSettings();
              }
            },

            child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                    isLocationSettings?'Open Location Settings':'Open App Settings',
                  style:txtStyle.copyWith(color: AppColors.bgColor),
                ),
             )
            )
          ],
        ),
      );
    }
  }
}
