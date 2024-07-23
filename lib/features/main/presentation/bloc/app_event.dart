part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeCurrentIndexEvent extends AppEvent {
  final int index;
  ChangeCurrentIndexEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
