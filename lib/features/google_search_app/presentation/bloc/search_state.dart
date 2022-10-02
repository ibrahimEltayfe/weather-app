part of 'search_cubit.dart';

@immutable
abstract class SearchState extends Equatable{
  const SearchState();
}

class SearchInitialState extends SearchState {
  const SearchInitialState();

  @override
  List<Object?> get props => [];
}

class SearchLoadingState extends SearchState {
  const SearchLoadingState();

  @override
  List<Object?> get props => [];
}

class SearchDataFetchedState extends SearchState {
  final List<SearchModel> searchedResults;
  const SearchDataFetchedState(this.searchedResults);

  @override
  List<Object?> get props => [searchedResults];
}

class SearchErrorState extends SearchState {
  final String message;
  const SearchErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
