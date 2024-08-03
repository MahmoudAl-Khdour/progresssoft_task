import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:progresssoft_task/features/app/data/models/countries_model.dart';
import 'package:progresssoft_task/features/app/domian/entites/countries_entity.dart';

import '../../../../json/json_reader.dart';

void main() {
  const testCountriesModel = CountriesModel(countries: ['JO', 'US']);

  test('Should be a subclass of Countries entity', () async {
    expect(testCountriesModel, isA<CountriesEntity>());
  });

  test('Should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('features/app/helper/dummy_data/dummy_country_response.json'),
    );

    // act
    final result = CountriesModel.fromJson(jsonMap);
    // assert
    expect(result, equals(testCountriesModel));
  });

  test('Should return a json map containing proper data', () async {
    // act
    final result = testCountriesModel.toJson();

    // assert
    final expectedJsonMap = {
      'countries': ['JO', 'US']
    };

    expect(result, equals(expectedJsonMap));
  });
}
