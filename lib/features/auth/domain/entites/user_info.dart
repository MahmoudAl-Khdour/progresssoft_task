import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String password;
  final int gender;
  final int age;

  const UserInfo({
    required this.fullName,
    required this.phoneNumber,
    required this.password,
    required this.gender,
    required this.age,
  });

  @override
  List<Object?> get props => [
        fullName,
        phoneNumber,
        password,
        gender,
        age,
      ];

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'password': password,
      'gender': gender,
      'age': age,
    };
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      gender: json['gender'] as int,
      age: json['age'] as int,
    );
  }

  static String encode(UserInfo userInfo) => json.encode(userInfo.toJson());

  static UserInfo decode(String userInfo) =>
      UserInfo.fromJson(json.decode(userInfo) as Map<String, dynamic>);
}
