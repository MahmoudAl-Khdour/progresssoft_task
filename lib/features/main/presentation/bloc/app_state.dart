part of 'app_bloc.dart';

@immutable
abstract class AppState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AppInitialState extends AppState {}

class ChangeCurrentIndexState extends AppState {
  final int index;
  ChangeCurrentIndexState({required this.index});

  @override
  List<Object?> get props => [index];
}
