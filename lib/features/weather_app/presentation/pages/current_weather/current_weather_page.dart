import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:lottie/lottie.dart';
import 'package:my_projects/constants/app_colors.dart';
import 'package:my_projects/constants/end_points.dart';
import 'package:my_projects/features/weather_app/domain/entities/weather_entity.dart';
import 'package:my_projects/features/weather_app/presentation/bloc/current_weather_cubit/current_weather_cubit.dart';
import 'package:my_projects/features/weather_app/presentation/bloc/weather_forecast_cubit/weather_forecast_cubit.dart';
import 'package:my_projects/features/weather_app/presentation/widgets/modal_bottom_sheet.dart';
import 'package:weather_icons/weather_icons.dart' show WeatherIcons,BoxedIcon;

import '../../../../../enums/geo_settings.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
          bottomSheet: const CustomModalBottomSheet(),
          drawerEnableOpenDragGesture: true,
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
                              return const _BuildLoadingWidget();
                            }else if(state is CurrentWeatherError){
                              return _BuildErrorWidget(errorState: state);
                            }else if(state is CurrentWeatherDataFetched){

                              WeatherEntity data = state.weatherData;

                              return Column(
                                children: [
                                  const SizedBox(height: 22,),

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

                                  const SizedBox(height: 21,),

                                  //image
                                  SvgPicture.asset(
                                    context.read<CurrentWeatherCubit>().getWeatherImage(
                                        main: data.weather![0].main!,
                                        dateTime: data.dt!,
                                        sunset: data.sys!.sunset!,
                                        sunrise: data.sys!.sunrise!,
                                        clouds: data.clouds!.all!
                                    ),
                                    width: 105,
                                    height: 105,
                                  ),

                                  const SizedBox(height: 21,),

                                  //temp
                                  Text(
                                      '${data.main!.temp!}',
                                      style: theme.textTheme.headline1!.copyWith(fontFamily: 'bahnsch', fontSize: 48,)
                                  ),

                                  const SizedBox(height: 8,),

                                  //desc
                                  Text(
                                    context.read<CurrentWeatherCubit>().capitalize('${data.weather![0].description}'),
                                    style:theme.textTheme.headline1!.copyWith(fontSize: 28) ,
                                  ),

                                  SizedBox(height: 24,),

                                  //additional info`s
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _BuildAdditionalInfo(
                                        icon: FontAwesomeIcons.wind,
                                        text: '${data.wind!.speed}m/s',
                                      ),
                                      _BuildAdditionalInfo(
                                        weatherIcon: WeatherIcons.humidity,
                                        text:'${data.main!.humidity!}%',
                                      ),
                                      _BuildAdditionalInfo(
                                        icon: FontAwesomeIcons.cloud,
                                        text:'${data.clouds!.all}%',
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 55,),

                                  //forecast
                                  Align(
                                    alignment: const Alignment(-0.75,0.0),
                                    child: Text(
                                      'Weather Forecast',
                                      style: theme.textTheme.headline1!.copyWith(fontSize: 25),
                                    ),
                                  ),

                                  const SizedBox(height: 14,),

                                  BlocBuilder<WeatherForecastCubit,WeatherForecastState>(
                                    builder: (context, state) {
                                      if(state is WeatherForecastLoading){
                                        return const Center(child: Text('loading'),);
                                      }else if(state is WeatherForecastError){
                                        return Center(child: Text(state.message),);
                                      }else if(state is WeatherForecastDataFetched){
                                     
                                        return Column(
                                          children: List.generate(5, (index) =>
                                              _BuildForecastData(
                                                  date: DateFormat('EEE, h:mm a').format(DateTime.fromMillisecondsSinceEpoch(
                                                      state.weatherData.temps![index].dt!*1000)
                                                  ),
                                                  icon: '${EndPoints.networkIcon}${state.weatherData.temps![index].weather![0].icon!}.png',
                                                  temp: state.weatherData.temps![index].main!.temp! as double,
                                              ),
                                          ),
                                        );
                                      }

                                      return const SizedBox.shrink();
                                    },

                                  ),

                                  const SizedBox(height: 12,),

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



}

class _BuildForecastData extends StatelessWidget {
  final String date;
  final double temp;
  final String icon;

  const _BuildForecastData({
    Key? key,
    required this.date,
    required this.temp,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  MediaQuery.of(context).size.width*0.96,
      height: 38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.28,
                child: FittedBox(child: Text(date,style:  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 20),))
            ),
          ),

          Image.network(icon,width: 32,height: 32,),
          //Icon(icon,size: 19.sp,),
          Flexible(
            child: SizedBox(
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('${temp.toStringAsFixed(1)}°',style:  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 20),)
                )
            ),
          )
        ],
      ),
    );
  }
}


class _BuildLoadingWidget extends StatelessWidget {
  const _BuildLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Lottie.asset('assets/lottie/wind.json',width:  MediaQuery.of(context).size.height*0.6,height:  MediaQuery.of(context).size.height*0.4,fit: BoxFit.contain),
    );
  }
}

class _BuildAdditionalInfo extends StatelessWidget {
  final IconData? icon;
  final String text;
  final IconData? weatherIcon;
  const _BuildAdditionalInfo({Key? key, this.icon, required this.text, this.weatherIcon,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child:BoxedIcon(weatherIcon!,)
            ),
          )
          :Icon(icon,size: 18,),

          const SizedBox(width: 12,),

          Text(text,style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),)
        ],
      ),
    );
  }
}

class _BuildErrorWidget extends StatelessWidget {
  final CurrentWeatherError errorState;
  const _BuildErrorWidget({Key? key, required this.errorState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(errorState.type == null){
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
              Text(errorState.message,style: Theme.of(context).textTheme.headline1!,)
            ],
          )
      );
    }else{
      bool isLocationSettings = errorState.type == GEOSettings.openLocationSettings.name;
      return SizedBox(
        width:  MediaQuery.of(context).size.width,
        height:  MediaQuery.of(context).size.height*0.95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorState.message,style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20)),

            const SizedBox(height: 14,),

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
                    style:Theme.of(context).textTheme.headline1!.copyWith(color: AppColors.bgColor),
                  ),
                )
            )
          ],
        ),
      );
    }
  }
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


/*List<Temps> tempsData = getCurrentDayForecast(data.dt!, state.weatherData);
                                        if(tempsData.isEmpty){
                                          return Center(child: Text("no forecast data for today,it is the end of the day.."),);
                                        }*/