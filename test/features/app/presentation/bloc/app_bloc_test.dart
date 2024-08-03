import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/core/strings/messages.dart';
import 'package:progresssoft_task/features/app/domian/entites/countries_entity.dart';
import 'package:progresssoft_task/features/app/domian/entites/validators.dart';
import 'package:progresssoft_task/features/app/presentation/bloc/app_bloc/app_bloc.dart';

import '../../helper/app_helper.mocks.dart';

void main() {
  late MockGetAllCountriesUseCase mockGetAllCountriesUseCase;
  late MockGetAllValidatorsUseCase mockGetAllValidatorsUseCase;
  late MockAppRepository mockAppRepository;
  late AppBloc appBloc;

  setUp(() {
    mockGetAllCountriesUseCase = MockGetAllCountriesUseCase();
    mockGetAllValidatorsUseCase = MockGetAllValidatorsUseCase();
    mockAppRepository = MockAppRepository();
    appBloc = AppBloc(
      getAllCountriesUseCase: mockGetAllCountriesUseCase,
      getAllValidatorsUseCase: mockGetAllValidatorsUseCase,
      appRepository: mockAppRepository,
    );
  });

  tearDown(() {
    appBloc.close();
  });

  group('GetCountriesEvent', () {
    const testCountries = CountriesEntity(countries: ['JO', 'US']);
    const failure = ServerFailure(message: 'Server error');

    test('emits [AppLoadingState, AppCountriesLoadedState] when successful',
        () async {
      // arrange
      when(mockGetAllCountriesUseCase.call())
          .thenAnswer((_) async => const Right(testCountries));

      // assert later
      final expected = [
        AppLoadingState(),
        AppCountriesLoadedState(countries: testCountries),
      ];

      // act
      expectLater(appBloc.stream, emitsInOrder(expected));

      // trigger event
      appBloc.add(GetCountriesEvent());
    });

    test('emits [AppLoadingState, AppErrorState] when unsuccessful', () async {
      // arrange
      when(mockGetAllCountriesUseCase.call())
          .thenAnswer((_) async => const Left(failure));

      // assert later
      final expected = [
        AppLoadingState(),
        AppErrorState(
            message: failure.message ?? AppMessages.somethingWentWrongMessage),
      ];

      // act
      expectLater(appBloc.stream, emitsInOrder(expected));

      // trigger event
      appBloc.add(GetCountriesEvent());
    });
  });

  group('GetValidatorsEvent', () {
    const testValidators = Validators(
      password: "^.{6,}",
      fullName: "^[A-Za-z]+(?: [A-Za-z]+)*",
      birthDate: "^(19|20)d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]d|3[01])",
      phone: {"+962": "^+962d{9}"},
    );
    const failure = ServerFailure(message: 'Server error');

    test('emits [AppLoadingState, AppValidatorsLoadedState] when successful',
        () async {
      // arrange
      when(mockGetAllValidatorsUseCase.call())
          .thenAnswer((_) async => const Right(testValidators));

      // assert later
      final expected = [
        AppLoadingState(),
        AppValidatorsLoadedState(validators: testValidators),
      ];

      // act
      expectLater(appBloc.stream, emitsInOrder(expected));

      // trigger event
      appBloc.add(GetValidatorsEvent());
    });

    test('emits [AppLoadingState, AppErrorState] when unsuccessful', () async {
      // arrange
      when(mockGetAllValidatorsUseCase.call())
          .thenAnswer((_) async => const Left(failure));

      // assert later
      final expected = [
        AppLoadingState(),
        AppErrorState(
            message: failure.message ?? AppMessages.somethingWentWrongMessage),
      ];

      // act
      expectLater(appBloc.stream, emitsInOrder(expected));

      // trigger event
      appBloc.add(GetValidatorsEvent());
    });
  });
}
