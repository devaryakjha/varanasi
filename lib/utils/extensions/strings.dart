extension StringExtension on String {
  /// Capitalize the first letter of the string
  String get capitalize => "${this[0].toUpperCase()}${substring(1)}";

  /// Sanitize the string by replacing some html characters
  String get sanitize {
    final ampersandRegex = RegExp(r'&amp;');
    final httpRegex = RegExp(r'http:');
    final quoteRegex = RegExp(r'&quot;|&#039;');
    return replaceAll(ampersandRegex, '&')
        .replaceAll(httpRegex, 'https:')
        .replaceAllMapped(quoteRegex, (match) {
      if (match.group(0) == '&quot;') {
        return '"';
      } else {
        return "'";
      }
    });
  }
}
