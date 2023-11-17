class InputValidators {
  static String? validateName(String? value) {
    // name should be at least 2 characters long
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name should be at least 2 characters long';
    }
    // name should not contain any numbers or special characters
    if (value.contains(RegExp(r'[0-9!@#\$&*~]'))) {
      return 'Name should not contain any numbers or special characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    // email should be in the format of an email address
    // make sure emails in format `john.doe+1@gmail.com` and `john.doe@gmail.com` both are accepted
    final regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    // password should be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number and one special character
    // do separate checks for each requirement
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password should be at least 8 characters long';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password should contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password should contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password should contain at least one number';
    }
    if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
      return 'Password should contain at least one special character';
    }
    return null;
  }
}
