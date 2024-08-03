import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/error/exceptions.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/core/strings/messages.dart';
import 'package:progresssoft_task/core/utils/constant/app_urls.dart';
import 'package:progresssoft_task/features/main/data/models/post_model.dart';

abstract class RemoteDataSources {
  Future<Either<Failure, List<PostModel>>> getAllPosts();
}

class PostRemoteDataSourcesImpl extends RemoteDataSources {
  final Dio dio;
  PostRemoteDataSourcesImpl({required this.dio});

  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    try {
      final getAllPostsResponse = await dio.get(Urls.allPosts);

      if (getAllPostsResponse.statusCode == 200) {
        List<PostModel> posts = (getAllPostsResponse.data as List)
            .map((json) => PostModel.fromJson(json))
            .toList();

        return Right(posts);
      } else {
        return Left(
            ServerFailure(message: AppMessages.somethingWentWrongMessage.tr));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
