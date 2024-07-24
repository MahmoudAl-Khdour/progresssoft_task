import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int? statusCode;
  final String? message;

  const Failure({
    this.statusCode,
    this.message,
  });
}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({super.statusCode, super.message});

  @override
  List<Object?> get props => [statusCode];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class WrongDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class FirebaseFailure extends Failure {
  @override
  List<Object?> get props => [];
}
