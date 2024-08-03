import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/exceptions.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/main/data/models/post_model.dart';
import 'package:progresssoft_task/features/main/data/repositories/post_repository_impl.dart';
import 'package:progresssoft_task/features/main/domain/entites/posts.dart';

import '../../helper/test_main_helper.mocks.dart';

void main() {
  late MockRemoteDataSources mockRemoteDataSources;
  late PostRepositoryImpl postRepositoryImpl;

  setUp(() {
    mockRemoteDataSources = MockRemoteDataSources();
    postRepositoryImpl =
        PostRepositoryImpl(remoteDataSources: mockRemoteDataSources);
  });

  const testPostModels = [
    PostModel(
      userId: 24,
      id: 1,
      title: 'Test post title',
      body: 'Test post body',
    ),
    PostModel(
      userId: 24,
      id: 2,
      title: 'Test post title',
      body: 'Test post body',
    ),
    PostModel(
      userId: 24,
      id: 3,
      title: 'Test post title',
      body: 'Test post body',
    ),
  ];

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

  group('get all posts', () {
    test(
      'should return a list of posts when the data source call is successful',
      () async {
        // arrange
        when(mockRemoteDataSources.getAllPosts())
            .thenAnswer((_) async => const Right(testPostModels));

        // act
        final result = await postRepositoryImpl.getAllPosts();

        // assert
        const expected = Right<Failure, List<Posts>>(testPosts);

        expect(result, equals(expected));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSources.getAllPosts()).thenThrow(ServerException());

        // act
        final result = await postRepositoryImpl.getAllPosts();

        // assert
        expect(result, const Left(ServerFailure(message: 'Server error')));
      },
    );

    test(
      'should return a failure when an unexpected exception is thrown',
      () async {
        // arrange
        when(mockRemoteDataSources.getAllPosts())
            .thenThrow(Exception('Unexpected error'));

        // act
        final result = await postRepositoryImpl.getAllPosts();

        // assert
        expect(result, const Left(ServerFailure(message: 'Unexpected error')));
      },
    );
  });
}
