class ApiExceptions implements Exception {
  final String errorMessage;
  final int? statusCode;

  ApiExceptions({required this.errorMessage, this.statusCode});
}
