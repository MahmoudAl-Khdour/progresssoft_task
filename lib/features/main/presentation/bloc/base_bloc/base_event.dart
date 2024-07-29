part of 'base_bloc.dart';

abstract class BaseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeCurrentIndexEvent extends BaseEvent {
  final int index;
  ChangeCurrentIndexEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
