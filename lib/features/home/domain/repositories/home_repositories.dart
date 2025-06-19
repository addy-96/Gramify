import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/home/domain/models/post_model.dart';

abstract interface class HomeRepositories {
  Future<Either<Failure, List<PostModel>>> loadUserFeeds();
}
