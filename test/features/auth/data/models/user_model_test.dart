import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:progresssoft_task/features/auth/data/models/user_model.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';

import '../../../../json/json_reader.dart';

void main() {
  const testUserModel = UserModel(
    fullName: 'Mahmoud Alkhdour',
    phoneNumber: '+962788314198',
    age: 24,
    gender: 1,
    password: '12345678',
  );

  test('Should be a subclass of userInfo entity', () async {
    expect(testUserModel, isA<UserInfo>());
  });

  test('Should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('features/auth/helper/dummy_data/dummy_user_info_response.json'),
    );

    // act
    final result = UserModel.fromMap(jsonMap);
    // assert
    expect(result, equals(testUserModel));
  });

  test('Should return a json map containing proper data', () async {
    // act
    final result = testUserModel.toJson();

    // assert
    final expectedJsonMap = {
      "fullName": "Mahmoud Alkhdour",
      "phoneNumber": "+962788314198",
      "password": "12345678",
      "gender": 1,
      "age": 24
    };

    expect(result, equals(expectedJsonMap));
  });
}
