import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

mixin DioErrorHandler {
  Either<String, T> handleDioError<T>(DioException de) {
    switch (de.type) {
      case DioExceptionType.connectionError:
        return left("Connection refused by server, please try again later");
      case DioExceptionType.connectionTimeout:
        return left(
            "Server took too long to respond, please retry later or check your connection");
      case DioExceptionType.receiveTimeout:
        return left(
            "Server did not send a response in time, please try again later.");
      case DioExceptionType.sendTimeout:
        return left("Sending request took too long, please try again later.");
      case DioExceptionType.unknown:
        try {
          final err = de.error as Response<dynamic>;
          return left(err.data["message"] ?? err.statusMessage);
        } catch (e) {
          return left(
            "An unexpected error occurred. Please try again later.",
          );
        }

      case DioExceptionType.badResponse:
        return left(
          de.response?.data["message"] ?? de.response?.statusMessage,
        );
      default:
        return left(de.response?.data["message"] ??
            de.response?.statusMessage ??
            "An unexpected error occurred. Please try again later.");
    }
  }
}
