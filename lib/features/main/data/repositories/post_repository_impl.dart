import 'package:dartz/dartz.dart';
import 'package:progresssoft_task/core/error/exceptions.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/features/main/data/data_sources/remote_data_sources.dart';
import 'package:progresssoft_task/features/main/domain/entites/posts.dart';
import 'package:progresssoft_task/features/main/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostsRepository {
  RemoteDataSources remoteDataSources;

  PostRepositoryImpl({required this.remoteDataSources});

  @override
  Future<Either<Failure, List<Posts>>> getAllPosts() async {
    try {
      final result = await remoteDataSources.getAllPosts();

      return result.fold(
        (failure) => Left(failure),
        (posts) {
          return Right(posts
              .map((postModel) => Posts(
                    userId: postModel.userId,
                    id: postModel.id,
                    title: postModel.title,
                    body: postModel.body,
                  ))
              .toList());
        },
      );
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
