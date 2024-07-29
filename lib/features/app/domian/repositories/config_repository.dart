import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/app/domian/entites/countries_entity.dart';
import 'package:progresssoft_task/features/app/domian/entites/validators.dart';

abstract class ConfigRepository {
  Future<Either<Failure, CountriesEntity>> getAllCountries();

  Future<Either<Failure, Validators>> getAllValidators();
}
