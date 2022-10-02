part of 'theme_manager_bloc.dart';

class ThemeManagerState extends Equatable {
  final ThemeData themeData;
  const ThemeManagerState(this.themeData);
  @override
  List<Object> get props => [themeData];
}