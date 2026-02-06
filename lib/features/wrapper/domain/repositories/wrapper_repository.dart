import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/wrapper/domain/entities/user.dart';

abstract class WrapperRepository {
  Future<Either<Failure, User>> fetchUser();
}
