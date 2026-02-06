import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/wrapper/data/datasorces/wrapper_data_source.dart';
import 'package:gramify/features/wrapper/domain/entities/user.dart';
import 'package:gramify/features/wrapper/domain/repositories/wrapper_repository.dart';

class WrapperRepositoriesImpl implements WrapperRepository {
  WrapperDataSource wrapperDataSource;
  WrapperRepositoriesImpl({required this.wrapperDataSource});
  @override
  Future<Either<Failure, User>> fetchUser() async {
    try {
      final user = await wrapperDataSource.fetchUser();
      return right(user);
    } catch (err) {
      return left(ServerFailure(err.toString()));
    }
  }
}
