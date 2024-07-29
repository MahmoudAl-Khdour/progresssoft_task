import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/strings/messages.dart';
import 'package:progresssoft_task/core/utils/repository/app_repository.dart';
import 'package:progresssoft_task/features/main/domain/entites/posts.dart';
import 'package:progresssoft_task/features/main/domain/usecases/get_all_posts.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetAllPostsUseCase getAllPostsUseCase;
  final AppRepository appRepository;

  MainBloc({
    required this.appRepository,
    required this.getAllPostsUseCase,
  }) : super(MainInitialState()) {
    on<GetPostsEvent>((event, emit) async {
      await _onGetAllPostsEvent(event, emit);
    });

    on<FilterPostsEvent>((event, emit) {
      if (appRepository.posts == null) {
        emit(PostsErrorState(message: AppMessages.noPostsAvailable.tr));
        return;
      }

      final filteredPosts = appRepository.posts!
          .where((post) =>
              post.title.contains(event.query) ||
              post.body.contains(event.query))
          .toList();

      emit(PostsLoadedState(posts: filteredPosts));
    });
  }

  Future<void> _onGetAllPostsEvent(
    GetPostsEvent event,
    Emitter<MainState> emit,
  ) async {
    emit(PostsLoadingState());
    final failureOrCountries = await getAllPostsUseCase.call();
    emit(failureOrCountries.fold(
      (failure) => PostsErrorState(
          message: failure.message ?? AppMessages.somethingWentWrongMessage),
      (posts) {
        appRepository.posts = posts;
        return PostsLoadedState(posts: posts);
      },
    ));
  }
}
