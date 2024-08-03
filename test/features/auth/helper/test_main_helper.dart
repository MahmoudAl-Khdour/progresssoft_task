import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:progresssoft_task/core/utils/repository/app_repository.dart';
import 'package:progresssoft_task/features/auth/domain/repositories/user_repository.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/auth_phone_number.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/create_user.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/sign_in.dart';
import 'package:progresssoft_task/features/auth/domain/usecases/verify_otp_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    UserRepository,
    FirebaseAuth,
    FirebaseFirestore,
    PhoneNumberAuthenticationUseCase,
    CreateUserUseCase,
    SignInUseCase,
    VerifyOTPUseCase,
    AppRepository,
    SharedPreferences,
    DocumentSnapshot<Map<String, dynamic>>,
    UserCredential,
  ],
)
void main() {}
