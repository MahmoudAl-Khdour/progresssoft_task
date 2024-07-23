import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository userRepository;
  CreateUserUseCase({required this.userRepository});

  Future<Either<Failure, Unit>> call({required UserInfo userInfo}) async {
    return await userRepository.createUser(userInfo: userInfo);
  }
}
