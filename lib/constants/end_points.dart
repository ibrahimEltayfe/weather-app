class EndPoints{
 // Weather App
  static const String baseUrl = 'api.openweathermap.org';
  static const String apiKey = '5c097c71276e355451670854f8ace526';
  static const String currentWeather = '/weather';
  static const String fiveDayForecast = '/forecast';
  static const String currentAirPollution = '/air_pollution';
  static const String airPollutionForecast = '/air_pollution/forecast';
  static const String historicalAirPollution = '/air_pollution/history';
  static const String networkIcon = 'https://openweathermap.org/img/wn/';

  static const String metricUnit = 'metric';

  static Map<String,dynamic> params({
   required String lat,
   required String lon,
   String? units,
   String? start,
   String? end
  }){
   return {
     'lat':lat,
     'lon':lon,
     'appid':apiKey,
      if(units!=null)'units':units,
      if(start!=null)'start':start,
      if(end!=null)'end':end,
   };
 }
}