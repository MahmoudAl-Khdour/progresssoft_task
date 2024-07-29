part of 'main_bloc.dart';

@immutable
abstract class MainState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MainInitialState extends MainState {}

class PostsLoadingState extends MainState {}

class PostsErrorState extends MainState {
  final String message;

  PostsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class PostsLoadedState extends MainState {
  final List<Posts> posts;

  PostsLoadedState({required this.posts});

  @override
  List<Object> get props => [posts];
}
