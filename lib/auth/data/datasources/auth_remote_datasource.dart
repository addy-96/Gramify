import 'dart:developer';

import 'package:gramify/core/errors/server_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> signUserUp({
    required String username,
    required String email,
    required String password,
  });

  Future<String> logUserIn({required String email, required String password});

  Future<String> logUserOut();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl({required this.supabase});

  final Supabase supabase;

  @override
  Future<String> logUserIn({
    required String email,
    required String password,
  }) async {
    log('received creds');
    log(email);
    try {
      final res = await supabase.client.auth.signInWithPassword(
        password: password,
        email: email,
      );

      log('${res.hashCode}');

      if (res.user == null) {
        throw ServerException(message: 'Authentication Failed!');
      }
      log('${res.user!.id} Signed Up');
      return res.user!.id;
    } on ServerException catch (err) {
      throw ServerException(message: err.toString());
    }
  }

  @override
  Future<String> logUserOut() {
    // TODO: implement logUserOut
    throw UnimplementedError();
  }

  @override
  Future<String> signUserUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final res = await supabase.client.auth.signUp(
        email: email,
        password: password,
      );

      log('${res.hashCode}');

      if (res.user == null) {
        throw ServerException(message: 'Failed! Server Authentication Error!');
      }

      log('${res.user!.id} Signed Up');
      return res.user!.id;
    } on ServerException catch (err) {
      throw ServerException(message: err.message);
    }
  }
}
