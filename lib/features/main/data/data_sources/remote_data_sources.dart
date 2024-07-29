import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/error/exceptions.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/core/strings/messages.dart';
import 'package:progresssoft_task/features/main/data/models/post_model.dart';

class RemoteDataSources {
  final String _getAllPostsUrl = "https://jsonplaceholder.typicode.com/posts";

  final Dio _dio = Dio(BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
  ));

  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    try {
      final getAllPostsResponse = await _dio.get(
        _getAllPostsUrl,
      );

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
