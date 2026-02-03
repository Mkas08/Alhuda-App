class ApiConstants {
  ApiConstants._();

  // Android Emulator: 10.0.2.2
  // iOS Simulator: 127.0.0.1
  // ngrok: https://postlabial-superformidable-peggy.ngrok-free.dev
  
  // TODO: Use environment variables via --dart-define
  static const String baseUrl = 'https://postlabial-superformidable-peggy.ngrok-free.dev/api/v1';
  // static const String baseUrl = 'http://10.0.2.2:8000/api/v1';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyCode = '/auth/verify-code';
  static const String resetPassword = '/auth/reset-password';
}
