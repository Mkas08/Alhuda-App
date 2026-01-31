abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String? message])
    : super(message ?? 'No Internet Connection');
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}
