class validationMixin {
  String validateEmail(v) {
    if (!v.contains('@') || !v.contains('.')) {
      return 'Invalid email address';
    }

    return null;
  }

  String validatePassword(v) {
    if (v.length < 4) {
      return 'Password needs to be at least 4 characters';
    }

    return null;
  }
}