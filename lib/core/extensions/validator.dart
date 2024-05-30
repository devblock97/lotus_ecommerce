
extension Validator on String {
  bool isValidEmail() {
    return RegExp(
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-z0-9]+\.[a-zA-Z]+"""
    ).hasMatch(this);
  }

  bool hasMatchPassword(String password) {
    return password.compareTo(this) == 0;
  }
}