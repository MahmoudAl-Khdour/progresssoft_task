import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';

class PhoneNumberAuthenticationUseCase {
  final UserRepository userRepository;
  PhoneNumberAuthenticationUseCase({required this.userRepository});

  Future<Either<Failure, Unit>> call({
    required String phoneNumber,
  }) async {
    return await userRepository.phoneNumberAuthentication(
      phoneNumber: phoneNumber,
    );
  }
}
