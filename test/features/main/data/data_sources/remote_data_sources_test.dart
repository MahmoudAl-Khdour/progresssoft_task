import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/exceptions.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/core/utils/constant/app_urls.dart';
import 'package:progresssoft_task/features/main/data/data_sources/remote_data_sources.dart';
import 'package:progresssoft_task/features/main/data/models/post_model.dart';

import '../../../../json/json_reader.dart';
import '../../helper/test_main_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late PostRemoteDataSourcesImpl postRemoteDataSourcesImpl;

  setUp(() {
    mockDio = MockDio();
    postRemoteDataSourcesImpl = PostRemoteDataSourcesImpl(dio: mockDio);
  });

  group('Get all posts', () {
    final url = Urls.allPosts;

    test('Should return posts model when the response code is 200', () async {
      // Arrange
      final jsonResponse = readJson(
          'features/main/helper/dummy_data/dymmy_list_posts_response.json');

      final responseData = jsonDecode(jsonResponse) as List<dynamic>;

      when(mockDio.get(url)).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: url),
        ),
      );

      // Act
      final result = await postRemoteDataSourcesImpl.getAllPosts();

      // Assert
      result.fold(
        (failure) =>
            fail('Expected a list of posts but got a failure: $failure'),
        (posts) {
          expect(posts, isA<List<PostModel>>());
          expect(posts.length, greaterThan(0));
        },
      );
    });

    test('Should return ServerFailure when the response code is not 200',
        () async {
      // Arrange
      when(mockDio.get(url)).thenAnswer(
        (_) async => Response(
          data: 'Something went wrong',
          statusCode: 404,
          requestOptions: RequestOptions(path: url),
        ),
      );

      // Act
      final result = await postRemoteDataSourcesImpl.getAllPosts();

      // Assert
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (posts) => fail('Expected a failure but got posts: $posts'),
      );
    });

    test('Should return ServerFailure on ServerException', () async {
      // Arrange
      when(mockDio.get(url)).thenThrow(ServerException(msg: 'Server Error'));

      // Act
      final result = await postRemoteDataSourcesImpl.getAllPosts();

      // Assert
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (posts) => fail('Expected a failure but got posts: $posts'),
      );
    });

    test('Should return ServerFailure on unexpected exception', () async {
      // Arrange
      when(mockDio.get(url)).thenThrow(Exception('Unexpected Error'));

      // Act
      final result = await postRemoteDataSourcesImpl.getAllPosts();

      // Assert
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (posts) => fail('Expected a failure but got posts: $posts'),
      );
    });
  });
}
