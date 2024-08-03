import 'package:progresssoft_task/features/app/domian/entites/validators.dart';

class ValidatorsModel extends Validators {
  const ValidatorsModel({
    required super.birthDate,
    required super.fullName,
    required super.password,
    required super.phone,
  });

  factory ValidatorsModel.fromJson(Map<String, dynamic> json) {
    final phoneMap = Map<String, String>.from(json['phone']);

    return ValidatorsModel(
      birthDate: json['birth_date'] ?? '',
      fullName: json['full_name'] as String,
      password: json['password'] as String,
      phone: phoneMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'birth_date': birthDate,
      'full_name': fullName,
      'password': password,
      'phone': phone,
    };
  }
}
