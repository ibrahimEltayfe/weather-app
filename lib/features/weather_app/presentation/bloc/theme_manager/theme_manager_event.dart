part of 'theme_manager_bloc.dart';

abstract class ThemeManagerEvent extends Equatable {
  const ThemeManagerEvent();
}

class ThemeChanged extends ThemeManagerEvent{

  @override
  List<Object?> get props => [];
}
