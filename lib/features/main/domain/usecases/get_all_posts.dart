import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/main/domain/entites/posts.dart';
import 'package:progresssoft_task/features/main/domain/repositories/post_repository.dart';

class GetAllPostsUseCase {
  final PostsRepository postsRepository;
  GetAllPostsUseCase({required this.postsRepository});

  Future<Either<Failure, List<Posts>>> call() async {
    return await postsRepository.getAllPosts();
  }
}
