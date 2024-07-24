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
    // Convert UserInfo to UserModel
    UserModel userModel = UserModel(
      fullName: userInfo.fullName,
      phoneNumber: userInfo.phoneNumber,
      password: userInfo.password,
      gender: userInfo.gender,
      age: userInfo.age,
    );

    try {
      final result = await firebaseService.createUser(user: userModel);

      return result;
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserInfo>> signIn({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final result = await firebaseService.signIn(
        phoneNumber: phoneNumber,
        password: password,
      );

      return result.fold(
        (failure) => Left(failure),
        (userModel) => Right(UserInfo(
          fullName: userModel.fullName,
          phoneNumber: userModel.phoneNumber,
          password: userModel.password,
          gender: userModel.gender,
          age: userModel.age,
        )),
      );
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> phoneNumberAuthentication({
    required String phoneNumber,
  }) async {
    try {
      final result =
          await firebaseService.phoneAuthentication(phoneNumber: phoneNumber);
      return result;
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOTP({required String otpCode}) async {
    try {
      final result = await firebaseService.verifyOTP(otpCode: otpCode);

      return result;
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
