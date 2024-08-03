import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:progresssoft_task/features/app/data/models/validators_model.dart';
import 'package:progresssoft_task/features/app/domian/entites/validators.dart';

import '../../../../json/json_reader.dart';

void main() {
  const testValidatorModel = ValidatorsModel(
    password: "^.{6,}",
    fullName: "^[A-Za-z]+(?: [A-Za-z]+)*",
    birthDate: "^(19|20)d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]d|3[01])",
    phone: {"+962": "^+962d{9}"},
  );

  test('Should be a subclass of Validators entity', () async {
    expect(testValidatorModel, isA<Validators>());
  });

  test('Should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('features/app/helper/dummy_data/dummy_validators_response.json'),
    );

    // act
    final result = ValidatorsModel.fromJson(jsonMap);
    // assert
    expect(result, equals(testValidatorModel));
  });

  test('Should return a json map containing proper data', () async {
    // act
    final result = testValidatorModel.toJson();

    // assert
    final expectedJsonMap = {
      "birth_date": "^(19|20)d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]d|3[01])",
      "full_name": "^[A-Za-z]+(?: [A-Za-z]+)*",
      "password": "^.{6,}",
      "phone": {"+962": "^+962d{9}"}
    };

    expect(result, equals(expectedJsonMap));
  });
}
