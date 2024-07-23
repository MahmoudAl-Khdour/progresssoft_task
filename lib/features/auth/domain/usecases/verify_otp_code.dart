import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';

class VerifyOTPUseCase {
  final UserRepository userRepository;
  VerifyOTPUseCase({required this.userRepository});

  Future<Either<Failure, Unit>> call({
    required String otpCode,
  }) async {
    return await userRepository.verifyOTP(otpCode: otpCode);
  }
}
