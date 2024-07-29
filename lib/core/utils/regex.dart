class RegexValidator {
  RegexValidator._();

  static bool isValid({required var filed, required String regexStatement}) {
    final RegExp regExp = RegExp(regexStatement);
    return regExp.hasMatch(filed);
  }

  static int extractDigitCount({required String regexPattern}) {
    // This is a simple approach to count the digit characters in the regex pattern
    final digitPattern = RegExp(r'\d');
    final matches = digitPattern.allMatches(regexPattern);
    return matches.length;
  }
}
