import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:progresssoft_task/core/utils/repository/app_repository.dart';
import 'package:progresssoft_task/features/main/data/data_sources/remote_data_sources.dart';
import 'package:progresssoft_task/features/main/domain/repositories/post_repository.dart';
import 'package:progresssoft_task/features/main/domain/usecases/get_all_posts.dart';

@GenerateMocks(
  [
    PostsRepository,
    RemoteDataSources,
    GetAllPostsUseCase,
    AppRepository,
  ],
  customMocks: [MockSpec<Dio>(as: #MockDio)],
)
void main() {}
