
import 'package:my_projects/error/network_checker.dart';

import '../data_source/api.dart';
import '../models/search_model.dart';

class SearchRepository{
  final NetworkInfo _connectionChecker;
  SearchRepository(this._connectionChecker);

  Future<List<SearchModel>> searchResults(String searchText) async{

    if(await _connectionChecker.isConnected){
      Map<String, dynamic>? data = await API.fetchData(searchText);
      List<SearchModel> searchModels = <SearchModel>[];

      data!['results'].map((map){
        searchModels.add(SearchModel.fromJson(map));
      }).toList();

      return searchModels;
    }else{
      throw Exception('no internet');
    }

  }
}