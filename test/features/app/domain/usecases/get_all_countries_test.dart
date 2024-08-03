import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/app/domian/entites/countries_entity.dart';
import 'package:progresssoft_task/features/app/domian/usecases/get_all_countries.dart';

import '../../helper/app_helper.mocks.dart';

void main() {
  late MockConfigRepository mockConfigRepository;
  late GetAllCountriesUseCase useCase;

  setUp(() {
    mockConfigRepository = MockConfigRepository();
    useCase = GetAllCountriesUseCase(configRepository: mockConfigRepository);
  });

  test(
      'Should return a list of countries when the repository call is successful',
      () async {
    // arrange
    const countries = CountriesEntity(countries: ['JO', 'US']);
    when(mockConfigRepository.getAllCountries())
        .thenAnswer((_) async => const Right(countries));

    // act
    final result = await useCase.call();

    // assert
    expect(result, const Right(countries));
    verify(mockConfigRepository.getAllCountries());
    verifyNoMoreInteractions(mockConfigRepository);
  });

  test('Should return a failure when the repository call fails', () async {
    // arrange
    const failure = ServerFailure(message: 'Error message');
    when(mockConfigRepository.getAllCountries())
        .thenAnswer((_) async => const Left(failure));

    // act
    final result = await useCase.call();

    // assert
    expect(result, const Left(failure));
    verify(mockConfigRepository.getAllCountries());
    verifyNoMoreInteractions(mockConfigRepository);
  });
}
