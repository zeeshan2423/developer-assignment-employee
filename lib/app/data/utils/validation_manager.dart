class ValidationManager {
  ValidationManager._();

  static bool validateName(String name) {
    const pattern = r'^[a-zA-Z].{2,}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(name);
  }
}
