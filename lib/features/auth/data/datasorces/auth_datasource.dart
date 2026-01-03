import 'package:dio/dio.dart';
import 'package:gramify/core/backend/api_routes.dart';
import 'package:gramify/core/errors/exceptions.dart';
import 'package:gramify/core/network/dio_service.dart';
import 'package:gramify/features/auth/data/models/user_model.dart';

abstract interface class AuthDatasource {
  Future<UserModel?> signUp({required String email, required String password, required String username, required String phone});
  Future<UserModel?> login({required String email, required String password});
  Future<bool> changePassword({required String email});
}

class AuthDatasourceImpl implements AuthDatasource {
  AuthDatasourceImpl({required this.apiRoutes, required this.dioService});
  final ApiRoutes apiRoutes;
  final DioService dioService;
  @override
  Future<bool> changePassword({required Comparable<String> email}) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> login({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> signUp({required String email, required String password, required String username, required String phone}) async {
    try {
      final response = await dioService.dio.post(ApiRoutes.registerAPI, data: {'email': email, 'password': password, 'username': username, 'phone': phone});
      return UserModel.fromJson(response.data);
    } on ApiExceptions catch (e) {
      rethrow;
    } on DioException catch (e) {
      throw ApiExceptions(errorMessage: e.response?.data['msg'] ?? e.response?.statusCode);
    } catch (err) {
      throw ApiExceptions(errorMessage: err.toString(), statusCode: 407);
    }
  }
}
