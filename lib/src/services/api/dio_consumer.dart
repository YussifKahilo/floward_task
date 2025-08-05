import 'package:dio/dio.dart';

import '../../errors/exceptions.dart';
import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;
  final Function(DioException e) handelDioError;
  DioConsumer(
      {required this.dio,
      required this.handelDioError,
      required String baseUrl}) {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    );
  }

  @override
  Future<Response> getData({
    required String url,
    dynamic query,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (headers != null) {
        dio.options.headers.addAll(headers);
      }
      return await dio.get(
        url,
        queryParameters: query,
      );
    } on DioException catch (e) {
      throw handelDioError(e)!;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Response> postData({
    required String url,
    dynamic query,
    required dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (headers != null) {
        dio.options.headers.addAll(headers);
      }
      return await dio.post(
        url,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw handelDioError(e)!;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Response> putData({
    required String url,
    dynamic query,
    required dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (headers != null) {
        dio.options.headers.addAll(headers);
      }
      return await dio.put(
        url,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw handelDioError(e)!;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Response> patchData({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (headers != null) {
        dio.options.headers.addAll(headers);
      }
      return await dio.patch(
        url,
        data: data,
      );
    } on DioException catch (e) {
      throw handelDioError(e)!;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Response> deleteData({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (headers != null) {
        dio.options.headers.addAll(headers);
      }
      return await dio.delete(
        url,
        data: data,
      );
    } on DioException catch (e) {
      throw handelDioError(e)!;
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
