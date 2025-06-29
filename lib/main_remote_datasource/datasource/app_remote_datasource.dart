import 'dart:developer';

import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/get_logged_userId.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AppRemoteDatasource {
  Future<void> setUserOline();
}

class AppRemoteDatasourceImpl implements AppRemoteDatasource {
  AppRemoteDatasourceImpl({required this.supaabse});
  final Supabase supaabse;
  @override
  Future<void> setUserOline() async {
    try {
      final loggedUserId = await getLoggedUserId();
      final res = await supaabse.client
          .from(userTable)
          .update({'last_seen': DateTime.now().toIso8601String()})
          .eq('user_id', loggedUserId);
    } catch (err) {
      log('error in setting user online: ${err.toString()}');
    }
  }
}
