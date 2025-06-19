class LocalMobileException implements Exception {
  final String message;
  LocalMobileException({required this.message});
  @override
  String toString() => message;
}
