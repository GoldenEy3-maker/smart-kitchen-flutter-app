sealed class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

class CacheFailure extends Failure {
  const CacheFailure({String? message}) : super(message ?? "Cache failure");

  @override
  String toString() => "CacheFailure: $message";
}

class UnknownFailure extends Failure {
  const UnknownFailure({String? message}) : super(message ?? "Unknown failure");

  @override
  String toString() => "UnknownFailure: $message";
}
