// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';

import '../base/error_response.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type.name) {
            // ignore: constant_pattern_never_matches_value_type
            case DioErrorType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            // ignore: constant_pattern_never_matches_value_type
            case DioErrorType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            // ignore: constant_pattern_never_matches_value_type
            case DioErrorType.unknown:
              errorDescription =
                  "Connection to API server failed due to internet connection";
              break;
            // ignore: constant_pattern_never_matches_value_type
            case DioErrorType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            // ignore: constant_pattern_never_matches_value_type
            case DioErrorType.badResponse:
              switch (error.response!.statusCode) {
                case 404:
                case 401:
                case 403:
                case 400:
                case 500:
                case 503:
                  errorDescription = error.response!.data['message'];
                  break;
                case 422:
                  errorDescription =
                      error.response!.data['value']['errors'][0]['message'];
                  break;
                default:
                  ErrorResponse errorResponse =
                      ErrorResponse.fromJson(error.response!.data);
                  if (errorResponse.error.isNotEmpty) {
                    errorDescription = errorResponse;
                  } else {
                    errorDescription =
                        "Failed to load data - status code: ${error.response!.statusCode}";
                  }
              }
              break;
            // ignore: constant_pattern_never_matches_value_type
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}
