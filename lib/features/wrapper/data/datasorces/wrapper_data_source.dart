import 'package:gramify/core/backend/api_routes.dart';
import 'package:gramify/core/network/dio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class WrapperDataSource {
  Future<void> fetchUserDetails();
}

class RemoteDataSourceImpl implements WrapperDataSource {
  RemoteDataSourceImpl({required this.apiRoutes, required this.dioService, required this.pref});
  final ApiRoutes apiRoutes;
  final DioService dioService;
  final SharedPreferences pref;

  @override
  Future<void> fetchUserDetails() {
    throw UnimplementedError();
  }
}
