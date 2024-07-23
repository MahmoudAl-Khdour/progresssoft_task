class RegexValidator {
  RegexValidator._();

  static bool isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneNumberRegExp = RegExp(r'^\d{9}$');
    return phoneNumberRegExp.hasMatch(phoneNumber);
  }

  static bool isValidFullName(String fullName) {
    final RegExp fullNameRegExp =
        RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
    return fullNameRegExp.hasMatch(fullName);
  }
}
