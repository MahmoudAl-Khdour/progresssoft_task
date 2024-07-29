import 'package:equatable/equatable.dart';

class Validators extends Equatable {
  final String birthDate;
  final String fullName;
  final String password;
  final Map<String, String> phone;

  const Validators({
    required this.birthDate,
    required this.fullName,
    required this.password,
    required this.phone,
  });

  @override
  List<Object?> get props => [birthDate, fullName, password, phone];
}
