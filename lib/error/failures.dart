import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message;
  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure{
  const ServerFailure(String message) : super(message:message);
}

class NoInternetFailure extends Failure{
  const NoInternetFailure(String message) : super(message:message);
}

class UnExpectedFailure extends Failure{
  const UnExpectedFailure(String message) : super(message:message);
}

class GeoPermissionFailure extends Failure{
  final String? errorIndex;
  const GeoPermissionFailure(String message,{required this.errorIndex,}) : super(message:message);
}
