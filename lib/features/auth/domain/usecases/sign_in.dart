import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';

class SignInUseCase {
  final UserRepository userRepository;
  SignInUseCase({required this.userRepository});

  Future<Either<Failure, UserInfo>> call({
    required String phoneNumber,
    required String password,
  }) async {
    return await userRepository.signIn(
        phoneNumber: phoneNumber, password: password);
  }
}
