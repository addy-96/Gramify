
import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';


abstract interface class UsecaseInterface<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params param);
}
