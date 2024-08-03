import 'package:equatable/equatable.dart';

class Posts extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Posts({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [userId, id, title, body];
}
