class BadRequestException implements Exception {
  final String message;
  final String? attribute;

  BadRequestException({
    required this.message,
    this.attribute,
  });
}