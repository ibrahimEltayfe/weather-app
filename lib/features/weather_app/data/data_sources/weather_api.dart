import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:my_projects/constants/end_points.dart';

class WeatherAPI{
  Future<Map<String,dynamic>> getData({
    required String lat,
    required String lon,
    required String endPointType,
    String? units,
    String? start,
    String? end
  }) async{

    Uri url = Uri.https(EndPoints.baseUrl,'/data/2.5$endPointType' ,EndPoints.params(lat: lat, lon: lon,units: units,start:start,end: end));
    http.Response response = await http.get(url);
    Map<String,dynamic> data = json.decode(response.body);
    return data;
    
  }
}