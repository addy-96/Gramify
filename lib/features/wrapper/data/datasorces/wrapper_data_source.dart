import 'package:dio/dio.dart';
import 'package:gramify/core/backend/api_routes.dart';
import 'package:gramify/core/errors/exceptions.dart';
import 'package:gramify/core/network/dio_service.dart';
import 'package:gramify/core/utils.dart';
import 'package:gramify/features/wrapper/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class WrapperDataSource {
  Future<UserModel> fetchUser();
}

class RemoteDataSourceImpl implements WrapperDataSource {
  RemoteDataSourceImpl({required this.apiRoutes, required this.dioService, required this.pref});
  final ApiRoutes apiRoutes;
  final DioService dioService;
  final SharedPreferences pref;

  @override
  Future<UserModel> fetchUser() async {
    try {
      final response = await dioService.dio.get(ApiRoutes.userRoute);
      return UserModel.fromJson(Utils.handleAPIResposne(response).jsonData);
    } on ApiExceptions catch (_) {
      rethrow;
    } on DioException catch (err) {
      throw ApiExceptions(errorMessage: err.toString());
    } catch (err) {
      throw ApiExceptions(errorMessage: err.toString());
    }
  }
}
