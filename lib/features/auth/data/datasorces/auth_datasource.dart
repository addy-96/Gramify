import 'package:dio/dio.dart';
import 'package:gramify/core/backend/api_routes.dart';
import 'package:gramify/core/errors/exceptions.dart';
import 'package:gramify/core/network/dio_service.dart';
import 'package:gramify/core/utils.dart';
import 'package:gramify/features/auth/data/models/auth_token_model.dart';

abstract interface class AuthDatasource {
  Future<AuthTokenModel> signUp({required String email, required String password, required String username, required String phone});
  Future<AuthTokenModel> login({required String email, required String password});
  Future<bool> changePassword({required String email});
  Future<bool> checkUsernameAvailability({required String typedUsername});
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
  Future<AuthTokenModel> login({required String email, required String password}) async {
    try {
      final response = await dioService.dio.post(ApiRoutes.loginAPIroute, data: {'email': email, 'password': password});

      return AuthTokenModel.fromJson(Utils.handleAPIResposne(response).jsonData);
    } on ApiExceptions catch (_) {
      rethrow;
    } on DioException catch (e) {
      throw ApiExceptions(errorMessage: e.response?.data['msg'] ?? e.response?.statusCode);
    } catch (err) {
      throw ApiExceptions(errorMessage: err.toString(), statusCode: 407);
    }
  }

  @override
  Future<AuthTokenModel> signUp({required String email, required String password, required String username, required String phone}) async {
    try {
      final response = await dioService.dio.post(
        ApiRoutes.registerAPIroute,
        data: {'email': email, 'password': password, 'username': username, 'phone': phone},
      );
      return AuthTokenModel.fromJson(Utils.handleAPIResposne(response).jsonData);
    } on ApiExceptions catch (_) {
      rethrow;
    } on DioException catch (e) {
      throw ApiExceptions(errorMessage: e.response?.data['msg'] ?? e.response?.statusCode);
    } catch (err) {
      throw ApiExceptions(errorMessage: err.toString(), statusCode: 407);
    }
  }

  @override
  Future<bool> checkUsernameAvailability({required String typedUsername}) async {
    try {
      final response = await dioService.dio.get(ApiRoutes.checkUsernameAPIroute, data: {'typedusername': typedUsername});
      return response.statusCode == 200;
    } on ApiExceptions catch (_) {
      rethrow;
    } on DioException catch (e) {
      throw ApiExceptions(errorMessage: e.response?.data['msg'] ?? e.response?.statusCode);
    } catch (err) {
      throw ApiExceptions(errorMessage: err.toString(), statusCode: 407);
    }
  }
}
