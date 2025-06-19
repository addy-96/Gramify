import 'package:fpdart/fpdart.dart';
import 'package:gramify/core/errors/failure.dart';
import 'package:gramify/features/explore/domain/model/search_people_model.dart';

abstract interface class ExploreRepository {
  Future<Either<Failure, List<SearchPeopleModel>>> searchPeople(
    String searchString,
  );
}
