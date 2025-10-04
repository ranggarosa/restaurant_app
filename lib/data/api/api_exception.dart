class ApiException implements Exception {
  final String messageKey;

  ApiException(this.messageKey);
}
