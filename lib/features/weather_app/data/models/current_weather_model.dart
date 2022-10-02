import 'package:my_projects/features/weather_app/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    Coord? coord,
    List<Weather>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? cityName,
    int? cod,
  }) : super(coord: coord, weather: weather, base: base, main: main, visibility: visibility, wind: wind, clouds: clouds, dt: dt, sys: sys, timezone: timezone, id: id, cityName: cityName, cod: cod);

  WeatherModel.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {weather!.add(Weather.fromJson(v));});
    }
    base = json['base'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    dt = json['dt'] as int;
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    cityName = json['name']?? '--';
    cod = json['cod'];
  }
}
