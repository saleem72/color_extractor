//

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? message;
  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

final class GeneralFailure extends Failure {
  const GeneralFailure({required String message}) : super(message);
}

final class NoInternetFailure extends Failure {
  const NoInternetFailure() : super('You have no internet connection');
}

final class ConnectionFailure extends Failure {
  const ConnectionFailure() : super('Check your connection');
}

final class DecodingFailure extends Failure {
  const DecodingFailure() : super('Some data are corrupted');
}

final class UnAuthorizedFailure extends Failure {
  const UnAuthorizedFailure() : super('You are not authorized to do this');
}

final class ForbiddenFailure extends Failure {
  const ForbiddenFailure() : super('You are not allowed to do this');
}

final class ServerFailure extends Failure {
  const ServerFailure() : super('Server Error: Some thing bad happened');
}

final class UnExpectedFailure extends Failure {
  const UnExpectedFailure({required String message}) : super(message);
}

final class ProductNotFoundFailure extends Failure {
  const ProductNotFoundFailure({required String message}) : super(message);
}

final class ValidationFailure extends Failure {
  const ValidationFailure({required String message}) : super(message);
}
