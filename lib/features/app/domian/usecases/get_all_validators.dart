import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/app/domian/entites/validators.dart';
import 'package:progresssoft_task/features/app/domian/repositories/config_repository.dart';

class GetAllValidatorsUseCase {
  final ConfigRepository configRepository;
  GetAllValidatorsUseCase({required this.configRepository});

  Future<Either<Failure, Validators>> call() async {
    return await configRepository.getAllValidators();
  }
}
