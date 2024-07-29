import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/exceptions.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/app/data/services/config_service.dart';
import 'package:progresssoft_task/features/app/domian/entites/countries_entity.dart';
import 'package:progresssoft_task/features/app/domian/entites/validators.dart';
import 'package:progresssoft_task/features/app/domian/repositories/config_repository.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  final FirebaseConfigService firebaseConfigService;

  ConfigRepositoryImpl({required this.firebaseConfigService});

  @override
  Future<Either<Failure, CountriesEntity>> getAllCountries() async {
    try {
      final result = await firebaseConfigService.getAllCountries();

      return result.fold(
        (failure) => Left(failure),
        (countriesModel) => Right(CountriesEntity(
          countries: countriesModel.countries,
        )),
      );
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Validators>> getAllValidators() async {
    try {
      final result = await firebaseConfigService.getAllValidators();

      return result.fold(
        (failure) => Left(failure),
        (validatorsModel) => Right(Validators(
          phone: validatorsModel.phone,
          fullName: validatorsModel.fullName,
          birthDate: validatorsModel.birthDate,
          password: validatorsModel.password,
        )),
      );
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
