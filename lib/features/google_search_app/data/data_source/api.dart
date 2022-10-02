import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:my_projects/constants/app_strings.dart';

class API{
  static Future<Map<String,dynamic>?> fetchData(String searchText) async{

     Response<Map<String,dynamic>> results = await Dio().get(
      '${AppStrings.googleAPI}$searchText&lr=lang_en&hl=en&cr=US',//&lang_ar - Arabic&hl=ar&cr=EG
        options: Options(
          contentType: 'application/json',
          headers: {
            "X-RapidAPI-Key": "a621e91a4fmshfa5384707e3db8ap134b55jsn38c6f8611a98",
          },
        ));

       if(results.statusCode == 200){
         return results.data;
       }else{
         throw Exception('failed to connect');
       }
}

}