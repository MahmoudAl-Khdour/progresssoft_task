import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/exceptions.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/auth/data/models/user_model.dart';
import 'package:progresssoft_task/features/auth/data/services/firebase_service.dart';
import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseService firebaseService;

  UserRepositoryImpl({required this.firebaseService});

  @override
  Future<Either<Failure, Unit>> createUser({required UserInfo userInfo}) async {
    UserModel userModel = UserModel(
      fullName: userInfo.fullName,
      phoneNumber: userInfo.phoneNumber,
      password: userInfo.password,
      gender: userInfo.gender,
      age: userInfo.age,
    );

    try {
      await firebaseService.createUser(user: userModel);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserInfo>> signIn({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      UserModel? userModel = await firebaseService.signIn(
        phoneNumber: phoneNumber,
        password: password,
      );

      if (userModel != null) {
        return Right(UserInfo(
          fullName: userModel.fullName,
          phoneNumber: userModel.phoneNumber,
          password: userModel.password,
          gender: userModel.gender,
          age: userModel.age,
        ));
      } else {
        return Left(ServerFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> phoneNumberAuthentication({
    required String phoneNumber,
  }) async {
    try {
      await firebaseService.phoneAuthentication(phoneNumber: phoneNumber);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOTP({required String otpCode}) async {
    try {
      await firebaseService.verifyOTP(otpCode: otpCode);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
