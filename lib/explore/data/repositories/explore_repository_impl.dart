import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/explore/data/datasources/explore_remote_datasource.dart';
import 'package:gramify/explore/domain/model/search_people_model.dart';
import 'package:gramify/explore/domain/repository/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  ExploreRepositoryImpl({required this.exploreRemoteDatasource});
  final ExploreRemoteDatasource exploreRemoteDatasource;

  @override
  Future<Either<Failure, List<SearchPeopleModel>>> searchPeople(
    String searchString,
  ) async {
    try {
      final res = await exploreRemoteDatasource.serachPeople(
        searchString: searchString,
      );
      return right(res);
    } catch (err) {
      log(err.toString());
      return left(Failure(message: err.toString()));
    }
  }
}
