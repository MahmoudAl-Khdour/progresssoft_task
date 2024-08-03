import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:progresssoft_task/features/main/data/models/post_model.dart';
import 'package:progresssoft_task/features/main/domain/entites/posts.dart';

import '../../../../json/json_reader.dart';

void main() {
  const testPostModel = PostModel(
    userId: 24,
    id: 1,
    title: 'Test post title',
    body: 'Test post body',
  );

  test('Should be a subclass of post entity', () async {
    expect(testPostModel, isA<Posts>());
  });

  test('Should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('features/main/helper/dummy_data/dymmy_posts_response.json'),
    );

    // act
    final result = PostModel.fromJson(jsonMap);
    // assert
    expect(result, equals(testPostModel));
  });

  test('Should return a json map containing proper data', () async {
    // act
    final result = testPostModel.toJson();

    // assert
    final expectedJsonMap = {
      "userId": 24,
      "id": 1,
      "title": "Test post title",
      "body": "Test post body"
    };

    expect(result, equals(expectedJsonMap));
  });
}
