import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';

abstract interface class AppRepositories {
  Future<Either<Failure, void>> setUserOnline();
}
