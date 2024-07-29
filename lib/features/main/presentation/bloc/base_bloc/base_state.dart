part of 'base_bloc.dart';

abstract class BaseState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class BaseInitialState extends BaseState {}

class ChangeCurrentIndexState extends BaseState {
  final int index;
  ChangeCurrentIndexState({required this.index});

  @override
  List<Object?> get props => [index];
}
