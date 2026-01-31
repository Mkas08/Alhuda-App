import 'package:dio/dio.dart';

class NetworkExceptions {
  static String getErrorMessage(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timed out. Please check your internet.";
        case DioExceptionType.sendTimeout:
          return "Send request timed out. Please check your internet.";
        case DioExceptionType.receiveTimeout:
          return "Receive response timed out. Please check your internet.";
        case DioExceptionType.badCertificate:
          return "Secure connection failed. Invalid certificate.";
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);
        case DioExceptionType.cancel:
          return "Request to server was cancelled.";
        case DioExceptionType.connectionError:
          return "No internet connection available.";
        case DioExceptionType.unknown:
          return "An unexpected error occurred. Please try again.";
      }
    } else {
      return "An unexpected error occurred. Please try again.";
    }
  }

  static String _handleBadResponse(Response<dynamic>? response) {
    if (response == null) return "Unknown server error.";
    final int? statusCode = response.statusCode;
    
    // Attempt to parse server message if available
    String? serverMessage;
    if (response.data is Map<String, dynamic>) {
       try {
         serverMessage = (response.data as Map<String, dynamic>)['detail'] as String?;
         serverMessage ??= (response.data as Map<String, dynamic>)['message'] as String?;
       } catch (_) {}
    }

    if (serverMessage != null && serverMessage.isNotEmpty) {
      return serverMessage;
    }

    switch (statusCode) {
      case 400:
        return "Invalid request. Please check your input.";
      case 401:
        return "Unauthorized. Please login again.";
      case 403:
        return "Access denied.";
      case 404:
        return "Resource not found.";
      case 500:
        return "Internal server error. Please try again later.";
      case 502:
        return "Server is momentarily offline. Please try again later.";
      case 503:
        return "Service unavailable. Please try again later.";
      case 504:
        return "Server request timed out. Please check your internet.";
      default:
        return "Unexpected server error (Code: $statusCode).";
    }
  }
}
