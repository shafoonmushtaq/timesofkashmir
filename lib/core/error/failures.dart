import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class HttpFailure extends Failure {}

class CacheFailure extends Failure {}

class InternetFailure extends Failure {}
