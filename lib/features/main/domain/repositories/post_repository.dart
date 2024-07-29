import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/main/domain/entites/posts.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Posts>>> getAllPosts();
}
