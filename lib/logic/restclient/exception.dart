class JSException implements Exception {
  final String message;
  final int code;

  const JSException([this.message = "", this.code = 0]);

  String toString() => "ZaboException: $message";
  int statusCode() => this.code;
}