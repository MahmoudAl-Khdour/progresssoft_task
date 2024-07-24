import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/error/exceptions.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/core/strings/messages.dart';
import 'package:progresssoft_task/features/auth/data/models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String? _verificationId;

  Future<Either<Failure, Unit>> createUser({
    required UserModel user,
  }) async {
    try {
      final userDoc =
          await _fireStore.collection('users').doc(user.phoneNumber).get();

      if (userDoc.exists) {
        return Left(
            ServerFailure(message: AppMessages.userAlreadyUsedMessage.tr));
      }

      await _fireStore
          .collection('users')
          .doc(user.phoneNumber)
          .set(user.toMap());

      return const Right(unit);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, Unit>> phoneAuthentication({
    required String phoneNumber,
  }) async {
    try {
      final userDoc =
          await _fireStore.collection('users').doc(phoneNumber).get();
      Either<Failure, Unit> result = const Right(unit);

      if (userDoc.exists) {
        return Left(
            ServerFailure(message: AppMessages.userAlreadyUsedMessage.tr));
      }

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (credential) async {
          try {
            await _auth.signInWithCredential(credential);
            result = const Right(unit);
          } catch (e) {
            result = Left(ServerFailure(message: e.toString()));
          }
        },
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
        verificationFailed: (error) {
          result = Left(ServerFailure(
              message: error.message ?? AppMessages.verificationFailed.tr));
        },
      );

      return result;
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, Unit>> verifyOTP({
    required String otpCode,
  }) async {
    try {
      await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: otpCode,
        ),
      );
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        return Left(
            ServerFailure(message: AppMessages.otpCodeInvalidMessage.tr));
      } else if (e.code == 'session-expired') {
        return Left(
            ServerFailure(message: AppMessages.otpCodeExpiredMessage.tr));
      } else if (e.code == 'too-many-requests') {
        return Left(
            ServerFailure(message: AppMessages.tooManyRequestsMessage.tr));
      } else {
        return Left(ServerFailure(
            message: e.message ?? AppMessages.somethingWentWrongMessage));
      }
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, UserModel>> signIn({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final userDoc =
          await _fireStore.collection('users').doc(phoneNumber).get();

      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null && userData['password'] == password) {
          return Right(UserModel.fromMap(userData));
        } else {
          return Left(
              ServerFailure(message: AppMessages.incorrectDataMessage.tr));
        }
      } else {
        return Left(
            ServerFailure(message: AppMessages.userDoesNotExistMessage.tr));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
