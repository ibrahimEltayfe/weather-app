import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/search_model.dart';
import '../../data/repository/repository.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repo;
  SearchCubit(this.repo) : super(const SearchInitialState());


 Future<void> getSearchResults(String searchText) async {
   try{
     emit(const SearchLoadingState());
     List<SearchModel> results = await repo.searchResults(searchText);
     emit(SearchDataFetchedState(results));

   }on SocketException catch(exp){
     emit(SearchErrorState(exp.message.toString()));
   }catch(exp){
     emit(SearchErrorState(exp.toString()));
   }

  }

}
