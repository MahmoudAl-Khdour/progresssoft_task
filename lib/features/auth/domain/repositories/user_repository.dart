import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> createUser({
    required UserInfo userInfo,
  });

  Future<Either<Failure, Unit>> phoneNumberAuthentication({
    required String phoneNumber,
  });

  Future<Either<Failure, Unit>> verifyOTP({
    required String otpCode,
  });

  Future<Either<Failure, UserInfo>> signIn({
    required String phoneNumber,
    required String password,
  });
}
