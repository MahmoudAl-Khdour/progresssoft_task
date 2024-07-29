import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/app/domian/entites/countries_entity.dart';
import 'package:progresssoft_task/features/app/domian/repositories/config_repository.dart';

class GetAllCountriesUseCase {
  final ConfigRepository configRepository;
  GetAllCountriesUseCase({required this.configRepository});

  Future<Either<Failure, CountriesEntity>> call() async {
    return await configRepository.getAllCountries();
  }
}
