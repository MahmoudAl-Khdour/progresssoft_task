part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppInitialState extends AppState {}

class AppLoadingState extends AppState {}

class AppErrorState extends AppState {
  final String message;

  AppErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class AppCountriesLoadedState extends AppState {
  final CountriesEntity countries;

  AppCountriesLoadedState({required this.countries});

  @override
  List<Object> get props => [countries];
}

class AppValidatorsLoadedState extends AppState {
  final Validators validators;

  AppValidatorsLoadedState({required this.validators});

  @override
  List<Object> get props => [validators];
}
