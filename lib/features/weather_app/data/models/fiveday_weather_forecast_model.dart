import 'package:my_projects/features/weather_app/domain/entities/five_day_forecast.dart';

class FiveDayForecastModel extends FiveDayForecastEntity{
  FiveDayForecastModel({
    String? cod,
    int? message,
    int? cnt,
    List<Temps>? temps,
    City? city,
}):super(cod:cod,message:message,cnt:cnt,temps:temps,city:city);

  FiveDayForecastModel.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      temps = <Temps>[];
      json['list'].forEach((v) {temps!.add(Temps.fromJson(v));});
    }
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }
}