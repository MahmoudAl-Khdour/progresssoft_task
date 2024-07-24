class OfflineException implements Exception {}

class ServerException implements Exception {
  final String msg;
  ServerException({required this.msg});
}

class EmptyCacheException implements Exception {}

class WrongDataException implements Exception {}

class FirebaseException implements Exception {}
