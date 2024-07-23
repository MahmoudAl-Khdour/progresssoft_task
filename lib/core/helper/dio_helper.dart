import 'package:dio/dio.dart';

class DioHelper {
  final Dio _dio;

  DioHelper({required Dio dio}) : _dio = dio;

  //for Dio helper testing only
  DioHelper.test({required Dio dio}) : _dio = dio;

  Future<Response> getRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response?> postRequest({
    required String? url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        url!,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response> patchRequest({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> putRequest({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> deleteRequest({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  DioException _handleError(DioException e) {
    String errorDescription = '';
    if (e.response != null) {
      errorDescription = e.response!.data.toString();
    } else {
      errorDescription = e.error.toString();
    }
    return DioException(
      response: e.response,
      type: e.type,
      error: errorDescription,
      requestOptions: e.requestOptions,
    );
  }
}
