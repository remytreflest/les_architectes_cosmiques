abstract class Failure {
  final String message;
  const Failure(this.message);
}

class StorageFailure extends Failure {
  const StorageFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}
