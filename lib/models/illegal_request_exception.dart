class IllegalRequestException implements Exception {
  final String message;

  IllegalRequestException(this.message);

  @override
  String toString() {
    return message;
  }
}