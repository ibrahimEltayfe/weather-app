import 'package:my_projects/features/weather_app/domain/entities/weather_entity.dart' hide Sys,Main,WeatherEntity;

class FiveDayForecastEntity {
  String? cod;
  int? message;
  int? cnt;
  List<Temps>? temps;
  City? city;

  FiveDayForecastEntity({this.cod, this.message, this.cnt, this.temps, this.city});

}

class Temps {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  Sys? sys;
  String? dtTxt;

  Temps(
      {this.dt,
        this.main,
        this.weather,
        this.clouds,
        this.wind,
        this.visibility,
        this.sys,
        this.dtTxt});

  Temps.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
     json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    visibility = json['visibility'];
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    dtTxt = json['dt_txt'];
  }
}

class Main {
  dynamic temp;
  dynamic tempMin;
  dynamic tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;

  Main(
      {this.temp,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.seaLevel,
        this.grndLevel,
        this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
  }
}

class Sys {
  String? pod;
  Sys({this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'];
  }
}

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City(
      {this.id,
        this.name,
        this.coord,
        this.country,
        this.population,
        this.timezone,
        this.sunrise,
        this.sunset});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '--';
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    country = json['country'] ?? '--';
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}