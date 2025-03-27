import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt servicelocator = GetIt.instance;

Future initDpendencies() async {
  await _authDepInit();
}

_authDepInit() {
  servicelocator.registerFactory(() => Supabase.instance);
}
