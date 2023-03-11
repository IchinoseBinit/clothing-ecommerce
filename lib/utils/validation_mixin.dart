class Validation {
  String? validateEmail(String value) {
    if (value.trim().isEmpty) {
      return "Please enter email";
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Please enter the valid email";
    }
    return null;
  }

  String? validatePassword(String value,
      {bool isConfirmPassword = false, String? confirmValue}) {
    if (value.trim().isEmpty) {
      return "Please enter password";
    }
    if (isConfirmPassword) {
      if (value != confirmValue) {
        return "Your passwords does not match";
      }
    }
    if (value.length < 5 ) {
      return "Please enter four letter password";
    }
    return null;
  }

  String? validate(String value, {required String title}) {
    if (value.trim().isEmpty) {
      return "Please enter your $title";
    }
    return null;
  }

  String? validateAge(String value) {
    if (value.trim().isEmpty) {
      return "Please enter your age";
    } else if (int.tryParse(value) == null) {
      return "Please enter a numeric value";
    }
    if (int.parse(value) < 0 || int.parse(value) > 150) {
      return "Please enter age more than 0 and less than 150";
    }
    return null;
  }

  String? validateNumber(String value, String title, double maxValue,
      {bool isPhoneNumber = false}) {
    if (value.trim().isEmpty) {
      return "Please enter $title";
    } else if (double.tryParse(value) == null) {
      return "Please enter a numeric value";
    }
    if ((double.parse(value) < 0 || double.parse(value) > maxValue) &&
        !isPhoneNumber) {
      return "Please enter $title more than 0 and less than ${maxValue.toInt()}";
    }
    return null;
  }

  validateUsername(String value, {String? title}) {
    if (value.isEmpty) {
      return title == null ? "Username is required" : "$title is required";
    }
    return null;
  }
}
