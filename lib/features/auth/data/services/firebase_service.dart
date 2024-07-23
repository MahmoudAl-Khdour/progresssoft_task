import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progresssoft_task/features/auth/data/models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String? _verificationId;

  Future<Unit> createUser({
    required UserModel user,
  }) async {
    await _fireStore
        .collection('users')
        .doc(user.phoneNumber)
        .set(user.toMap());

    return unit;
  }

  Future<Unit> phoneAuthentication({
    required String phoneNumber,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
      verificationFailed: (error) {
        throw Exception(error);
      },
    );

    return unit;
  }

  Future<Unit> verifyOTP({
    required String otpCode,
  }) async {
    await _auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otpCode));
    return unit;
  }

  Future<UserModel?> signIn({
    required String phoneNumber,
    required String password,
  }) async {
    final userDoc = await _fireStore.collection('users').doc(phoneNumber).get();

    if (userDoc.exists) {
      final userData = userDoc.data();
      if (userData != null && userData['password'] == password) {
        return UserModel.fromMap(userData);
      }
    }
    return null;
  }
}
