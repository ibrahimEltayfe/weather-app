class AirPollutionEntity {
  Coord? coord;
  List<DataList>? dataList;

  AirPollutionEntity({this.coord, this.dataList});
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'] as double;
    lat = json['lat'] as double;
  }
}

class DataList {
  Main? main;
  Components? components;
  int? dt;

  DataList({this.main, this.components, this.dt});

  DataList.fromJson(Map<String, dynamic> json) {
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    components = json['components'] != null
        ? Components.fromJson(json['components'])
        : null;
    dt = json['dt'];
  }
}

class Main {
  int? aqi;
  Main({this.aqi});

  Main.fromJson(Map<String, dynamic> json) {
    aqi = json['aqi'] as int;
  }

}

class Components {
  double? co;
  int? no;
  double? no2;
  double? o3;
  double? so2;
  double? pm25;
  double? pm10;
  int? nh3;

  Components(
      {this.co,
        this.no,
        this.no2,
        this.o3,
        this.so2,
        this.pm25,
        this.pm10,
        this.nh3});

  Components.fromJson(Map<String, dynamic> json) {
    co = json['co'];
    no = json['no'];
    no2 = json['no2'];
    o3 = json['o3'];
    so2 = json['so2'];
    pm25 = json['pm2_5'];
    pm10 = json['pm10'];
    nh3 = json['nh3'];
  }
}