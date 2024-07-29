part of 'main_bloc.dart';

@immutable
abstract class MainEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPostsEvent extends MainEvent {}

class FilterPostsEvent extends MainEvent {
  final String query;

  FilterPostsEvent(this.query);
}
