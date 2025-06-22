import 'dart:async';

abstract interface class MainRemoteDatasource {
  Future<void> setUserStatus();
}

void startHeartbeat() {
  Timer.periodic(const Duration(seconds: 30), (Timer timer) {
    print("Heartbeat sent at ${DateTime.now()}");
    // Add your Supabase update logic here
  });
}
