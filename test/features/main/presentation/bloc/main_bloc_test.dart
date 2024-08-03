import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/main/domain/entites/posts.dart';
import 'package:progresssoft_task/features/main/presentation/bloc/main_bloc/main_bloc.dart';

import '../../helper/test_main_helper.mocks.dart';

void main() {
  late MockGetAllPostsUseCase mockGetAllPostsUseCase;
  late MockAppRepository mockAppRepository;
  late MainBloc mainBloc;

  setUp(() {
    mockGetAllPostsUseCase = MockGetAllPostsUseCase();
    mockAppRepository = MockAppRepository();
    mainBloc = MainBloc(
      appRepository: mockAppRepository,
      getAllPostsUseCase: mockGetAllPostsUseCase,
    );
  });

  const testPosts = [
    Posts(
      userId: 24,
      id: 1,
      title: 'Test post title',
      body: 'Test post body',
    ),
    Posts(
      userId: 24,
      id: 2,
      title: 'Test post title',
      body: 'Test post body',
    ),
    Posts(
      userId: 24,
      id: 3,
      title: 'Test post title',
      body: 'Test post body',
    ),
  ];

  const testQuery = 'Test';

  test('Initial state should be MainInitialState', () {
    expect(mainBloc.state, isA<MainInitialState>());
  });

  blocTest<MainBloc, MainState>(
    'should emit [PostsLoadingState, PostsLoadedState] when data is gotten successfully',
    build: () {
      when(mockGetAllPostsUseCase.call())
          .thenAnswer((_) async => const Right(testPosts));
      return mainBloc;
    },
    act: (bloc) => bloc.add(GetPostsEvent()),
    expect: () => [
      isA<PostsLoadingState>(),
      PostsLoadedState(posts: testPosts),
    ],
  );

  blocTest<MainBloc, MainState>(
    'should emit [PostsLoadingState, PostsErrorState] when data retrieval is unsuccessful',
    build: () {
      when(mockGetAllPostsUseCase.call()).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Error message')));
      return mainBloc;
    },
    act: (bloc) => bloc.add(GetPostsEvent()),
    expect: () => [
      isA<PostsLoadingState>(),
      PostsErrorState(message: 'Error message'),
    ],
  );

  blocTest<MainBloc, MainState>(
    'Should emit [PostsLoadedState] when filtering posts',
    build: () {
      when(mockAppRepository.posts).thenReturn(testPosts);
      return mainBloc;
    },
    act: (bloc) => bloc.add(FilterPostsEvent(testQuery)),
    expect: () => [
      PostsLoadedState(
          posts: testPosts
              .where((post) =>
                  post.title.contains(testQuery) ||
                  post.body.contains(testQuery))
              .toList()),
    ],
  );
}
