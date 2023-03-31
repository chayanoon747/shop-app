extension extString on String {
  // true : (minimum 4, maximum 20) and use a-z,A-Z,0-9
  bool get isValidUsername {
    final usernameRegExp = RegExp(r'^(?=.{4,20}$)(?:[a-zA-Z\d])+$');
    return usernameRegExp.hasMatch(this);
  }

  // true : (minimum 6, maximum 20) and use a-z,A-Z,0-9 and followed by . | _ | - | @ | # | $ | % | &
  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,20}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{9}$");
    return phoneRegExp.hasMatch(this);
  }
}
