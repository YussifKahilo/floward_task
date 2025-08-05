import 'dart:developer';

import 'package:dio/dio.dart';

import '../../errors/exceptions.dart';
import 'status_code.dart';

dynamic handelDioError(DioException error) {
  try {
    log(error.response!.data['message'].toString());
  } catch (e) {}
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      throw const FetchDataException();
    case DioExceptionType.badResponse:
      switch (error.response?.statusCode) {
        case StatusCode.badRequest:
          throw BadRequestException(error.response!.data['message']);
        case StatusCode.unauthorized:
        // Navigator.pushNamedAndRemoveUntil(
        //   MyApp.navigatorKey.currentContext!,
        //   LoginScreen.route,
        //   (route) => false,
        //   arguments: false,
        // );
        case StatusCode.forbidden:
          throw UnauthorizedException(error.response!.data['message']);
        case StatusCode.notFound:
          throw NotFoundException(error.response!.data['message']);
        case StatusCode.conflict:
          throw ConflictException(error.response!.data['message']);
        case StatusCode.internalServer:
          throw ConflictException(error.response!.data['message']);
        // throw const InternalServerErrorException();

        default:
          throw ServerException(error.response!.data['message']);
      }
    case DioExceptionType.cancel:
      throw const ServerException('Canceled');

    case DioExceptionType.unknown:
      throw const NoInternetConnectionException();
    default:
      return ServerException(
          error.response?.data['message'] ?? error.message ?? 'Unknown Error');
  }
}
