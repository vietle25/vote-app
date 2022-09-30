class ErrorCode {
  //
  static const int success = 0; // Success
  static const int common = 1; // Error common

  //authentication
  static const int accountExisted = 101; // existed account
  static const int passwordMismatch = 102;
  static const int invalidAccount = 103;
  static const int authenticateRequired = 104;
  static const int userTempNeedConfirmOTP = 105; // user need confirm otp

  static const int userBanned = 108; // use banned, deleted or blocked
  static const int forbiddenAction = 109; // Forbidden action
  static const int phoneAlreadyLinked = 110;
  static const int emailExisted = 111; // existed email
  static const int deviceNotRegister =
      404; // Device has not been registered (getOPT Code has not been sent
  static const int wrongOtp = 405; // Wrong OTP Code
  static const int unauthorised =
      403; // Timeout session, (check with firebase), missing AccessToken in header
  static const int sessionTimeout =
      401; // Timeout session, (check with firebase), missing AccessToken in header
  static const int deactivate =
      406; // Account has not been activated, this account does not contain a student.
  static const int permissionDenied = 407; // User login is not employee

  static const int internalServerError = 500; // Server error
}
