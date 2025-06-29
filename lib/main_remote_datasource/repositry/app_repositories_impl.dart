import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/main_domain/repository/app_repositories.dart';
import 'package:gramify/main_remote_datasource/datasource/app_remote_datasource.dart';

class AppRepositoriesImpl implements AppRepositories {
  final AppRemoteDatasource appRemoteDatasource;
  AppRepositoriesImpl({required this.appRemoteDatasource});
  @override
  Future<Either<Failure, void>> setUserOnline() async {
    try {
      final res = await appRemoteDatasource.setUserOline();
      return right(res);
    } catch (err) {
      return left(Failure(message: err.toString()));
    }
  }
}
