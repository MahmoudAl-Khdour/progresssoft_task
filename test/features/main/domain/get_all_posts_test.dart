import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/main/domain/entites/posts.dart';
import 'package:progresssoft_task/features/main/domain/usecases/get_all_posts.dart';

import '../helper/test_main_helper.mocks.dart';

void main() {
  late GetAllPostsUseCase getAllPostsUseCase;
  late MockPostsRepository mockPostsRepository;

  setUp(() {
    mockPostsRepository = MockPostsRepository();
    getAllPostsUseCase =
        GetAllPostsUseCase(postsRepository: mockPostsRepository);
  });

  const testListPosts = [
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

  group('GetAllPostsUseCase', () {
    test('Should return a list of posts when the repository call is successful',
        () async {
      // Arrange
      when(mockPostsRepository.getAllPosts())
          .thenAnswer((_) async => const Right(testListPosts));

      // Act
      final result = await getAllPostsUseCase();

      // Assert
      expect(result, const Right(testListPosts));
    });

    test('Should return a Failure when the repository call fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Server error');
      when(mockPostsRepository.getAllPosts())
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await getAllPostsUseCase();

      // Assert
      expect(result, const Left(failure));
    });
  });
}
