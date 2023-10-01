String? validateEmail(String? value) {
  // Pattern for email validation
  const pattern =
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
  final regExp = RegExp(pattern);

  if (value == "") {
    return 'Please enter your email address.';
  } else if (!regExp.hasMatch(value!)) {
    return 'Please enter a valid email address.';
  }

  return ""; // Return null if the email is valid
}

String? validatePassword(String? value) {
  if (value == "") {
    return 'Password is required';
  }

  // Add any additional password requirements or constraints here
  // For example, you can check for the presence of special characters,
  // uppercase letters, etc.

  return ""; // Return null if the password is valid
}
