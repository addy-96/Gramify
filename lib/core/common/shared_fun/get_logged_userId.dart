import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<String> getLoggedUserId() async {
  final pref = await SharedPreferences.getInstance();
  final Supabase supabse = Supabase.instance;

  final userID = pref.getString(userIdSharedKey);

  if (userID == null) {
    final userId = supabse.client.auth.currentUser!.id;
    await pref.setString(userIdSharedKey, userId);
  }
  return userID!;
}
