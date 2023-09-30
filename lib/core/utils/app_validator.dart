class AppValidator {
  static String? validatorRequired(value) {
    if (value == null || value.isEmpty) {
      return REQUIRED_FIELD;
    }
    return null;
  }

  String? validatePassword(String? password, {String? confirmPassword}) {
    if (password == null || password.isEmpty) {
      return REQUIRED_FIELD;
    }
    // if (!password.contains(new RegExp(r'[A-Z]'))) {
    //   return AppStrings.UPPER_CASE;
    // }
    //
    // if (!password.contains(new RegExp(r'[a-z]'))) {
    //   return AppStrings.LOWER_CASE;
    // }
    //
    // if (!password.contains(new RegExp(r'[0-9]'))) {
    //   return AppStrings.NUMBER_PASSWORD;
    // }

    // if (password.contains(
    //         RegExp(r'[!"#$%&()*+,-./:;<=>?@[\]^_`{|}~€¢¥£©®™✓•√π÷×¶∆]')) ||
    //     password.contains(RegExp(r"[']"))) {
    //   return AppStrings.PASSWORD_SPECIAL_CHARACTER;
    // }

    if (confirmPassword != null && password != confirmPassword) {
      return INVALID_PASSWORD_CONFIRMATION;
    }

    if (password.length < 6 || password.length > 16) {
      return INVALID_PASSWORD_LENGTH;
    }

    return null;
  }

  String? validatorEmail(String? value) {
    if (value == null || value.isEmpty) {
      return REQUIRED_FIELD;
    }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);

    if (value.isEmpty || !emailValid) {
      return INVALID_EMAIL_ADDRESS;
    }

    return null;
  }

  // static String? validatorName(String? value, BuildContext context) {
  //   if (value == null || value.isEmpty) {
  //     return AppStrings.REQUIRED;
  //   }
  //   // range 3-50
  //   if (value.length < 3 || value.length > 20) {
  //     return AppStrings.NAME_LENGHT_ERROR;
  //   }
  //   // only english letters
  //   if (!RegExp(r'[a-zA-Z]+$').hasMatch(value) ||
  //       value.contains(new RegExp(r'[0-9]'))) {
  //     return AppStrings.CONSIST_OF_ONLY_CHAR;
  //   }

  //   // starts with upper case
  //   if (!value[0].contains(new RegExp(r'[A-Z]')))
  //     return AppStrings.START_WITH_UPPER;

  //   return null;
  // }

  String? validateMobile(String? value, String? dialNumber) {
    if (value != null && dialNumber != null && value.isNotEmpty) {
      String number = dialNumber + value;
      if (number.length >= 9 && number.length <= 15) {
        return null;
      } else {
        return INVALID_PHONE_NUMBER_LENGTH;
      }
    } else {
      return INVALID_PHONE_NUMBER;
    }
  }

  Future<String?> validatePhoneNumber(String? value) async {
    if (value != null && value.isNotEmpty) {
      try {
        if (value[0] == '0' && value.length == 10) {
          return null;
        }
      } catch (e) {
        return INVALID_PHONE_NUMBER;
      }
    } else {
      return INVALID_PHONE_NUMBER;
    }
    return null;
  }

  String? validateCountryCode(String? value, String? dialNumber) {
    if (value != null && dialNumber != null && value.isNotEmpty) {
      String number = dialNumber + value;
      if (number.length >= 9 && number.length <= 15) {
        return null;
      } else {
        return " ";
      }
    } else {
      return " ";
    }
  }
}

const REQUIRED_FIELD = "Required";
const INVALID_EMAIL = "Invalid email";
const INVALID_PASSWORD = "Invalid password";
const INVALID_PHONE_NUMBER = "Invalid phone number";
const INVALID_USERNAME = "Invalid username";
const INVALID_CONFIRM_PASSWORD = "Invalid password confirmation";
const INVALID_FIRST_NAME = "Invalid first name";
const INVALID_LAST_NAME = "Invalid last name";
const INVALID_EMAIL_ADDRESS = "Invalid email address";
const INVALID_PASSWORD_LENGTH = "Invalid password length";
const INVALID_PHONE_NUMBER_LENGTH = "Invalid phone number length";
const INVALID_USERNAME_LENGTH = "Invalid username length";
const INVALID_CONFIRM_PASSWORD_LENGTH = "Invalid password confirmation length";
const INVALID_FIRST_NAME_LENGTH = "Invalid first name length";
const INVALID_LAST_NAME_LENGTH = "Invalid last name length";
const INVALID_EMAIL_ADDRESS_LENGTH = "Invalid email address length";
const INVALID_PASSWORD_CONFIRMATION = "Password confirmation doesn't match";
const INVALID_EMAIL_ADDRESS_FORMAT = "Invalid email address format";
const INVALID_CODE_LENGTH = "Invalid code length";

// const REQUIRED_FIELD = "مطلوب";
// const INVALID_EMAIL = "بريد إلكتروني خاطئ";
// const INVALID_PASSWORD = "رمز مرور خاطئ";
// const INVALID_PHONE_NUMBER = "رقم الهاتف غير صحيح";
// const INVALID_USERNAME = "اسم مستخدم غير صالح";
// const INVALID_CONFIRM_PASSWORD = "تأكيد كلمة المرور غير صالحة";
// const INVALID_FIRST_NAME = "الاسم الأول غير صالح";
// const INVALID_LAST_NAME = "الاسم الأخير غير صالح";
// const INVALID_EMAIL_ADDRESS = "عنوان البريد الإلكتروني غير صالح";
// const INVALID_PASSWORD_LENGTH = "طول كلمة المرور غير صالحة";
// const INVALID_PHONE_NUMBER_LENGTH = "طول رقم الهاتف غير صالح";
// const INVALID_USERNAME_LENGTH = "طول اسم المستخدم غير صالح";
// const INVALID_CONFIRM_PASSWORD_LENGTH = "تأكيد غير صالح طول كلمة المرور";
// const INVALID_FIRST_NAME_LENGTH = "طول الاسم الأول غير صالح";
// const INVALID_LAST_NAME_LENGTH = "طول الاسم الأخير غير صالح";
// const INVALID_EMAIL_ADDRESS_LENGTH = "طول عنوان البريد الإلكتروني غير صالح";
// const INVALID_PASSWORD_CONFIRMATION = "تأكيد كلمة المرور غير متطابقة";
// const INVALID_EMAIL_ADDRESS_FORMAT = "شكل عنوان البريد الإلكتروني غير صالح";
// const INVALID_CODE_LENGTH = "طول الرمز غير صالح";
