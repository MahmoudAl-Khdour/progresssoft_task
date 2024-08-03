import 'package:progresssoft_task/features/auth/domain/entites/user_info.dart';

class UserModel extends UserInfo {
  const UserModel({
    required super.fullName,
    required super.phoneNumber,
    required super.password,
    required super.gender,
    required super.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'password': password,
      'gender': gender,
      'age': age,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      gender: map['gender'],
      age: map['age'],
    );
  }
}
