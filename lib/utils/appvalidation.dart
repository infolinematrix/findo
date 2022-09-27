class AppValidation {
  static String? validateMobileNumber(value) {
    RegExp regex = RegExp(r'^[1-9]\d{9}$');
    if (!regex.hasMatch(value)) {
      return 'Invalid Mobile Number';
    } else {
      return "";
    }
  }

  static String? validatePanNumber(value) {
    Pattern pattern = r'[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Invalid Pan Number';
    } else {
      return "";
    }
  }

  static String? validateAadharNumber(value) {
    Pattern pattern = r'^[0-9]{12}$';
    // Pattern pattern = r'[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Invalid Aadhaar Number';
    } else {
      return "";
    }
  }

  static String? validateEmailAddress(value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Invalid Email Address';
    } else {
      return "";
    }
  }

  static String? validateGstNO(value) {
    Pattern pattern = r'^[A-Z0-9]{15}$';
    // Pattern pattern = r'^([^<>]){1,10}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Invalid GST Number';
    } else {
      return "";
    }
  }

  static String? validatePinCode(value) {
    RegExp regex = RegExp(r'^[1-9]\d{5}$');
    if (!regex.hasMatch(value)) {
      return 'Invalid Pincode';
    } else {
      return "";
    }
  }

  static String? validateOtpCode(value) {
    RegExp regex = RegExp(r'^[1-9]\d{5}$');
    if (!regex.hasMatch(value)) {
      return 'Invalid OTP';
    } else {
      return "";
    }
  }

  static String? validateBuyerAddress(value) {
    Pattern pattern = r'^[^@&#%;\\]+$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'You can\'t use (@,&,#,%,;,) in this field';
    } else {
      return "";
    }
  }
}
