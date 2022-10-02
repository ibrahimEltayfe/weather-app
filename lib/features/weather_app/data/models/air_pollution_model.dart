import '../../domain/entities/air_pollution_entity.dart';

class AirPollutionModel extends AirPollutionEntity{

  AirPollutionModel({
    Coord? coord,
    List<DataList>? dataList,}
   ):super(coord: coord,dataList: dataList);

  AirPollutionModel.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    if (json['list'] != null) {
      dataList = <DataList>[];
      json['list'].forEach((v) {
        dataList!.add(DataList.fromJson(v));
      });
    }
  }
}

