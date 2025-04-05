class AppException implements Exception {
  final String message;
  final String code;
  final String? identifier;
  final String? data;

  AppException({required this.message, required this.code, this.data, this.identifier});

  @override
  String toString() {
    return '''
{
  "code": "$code",
  "message": "$message",
  ${data != null ? '"data": "$data",' : ''}
  ${identifier != null ? '"identifier": "$identifier",' : ''}
}
''';
  }
}
