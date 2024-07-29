import 'package:equatable/equatable.dart';

class ValidatorsModel extends Equatable {
  final String birthDate;
  final String fullName;
  final String password;
  final Map<String, String> phone;

  const ValidatorsModel({
    required this.birthDate,
    required this.fullName,
    required this.password,
    required this.phone,
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
      'birth_Date': birthDate,
      'full_name': fullName,
      'password': password,
      'phone': phone,
    };
  }

  @override
  List<Object?> get props => [birthDate, fullName, password, phone];
}
