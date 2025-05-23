class Validators {
  static String? validateEmail(String? email,
      {String error = "Enter a valid email address"}) {
    return isEmail(email)! ? null : error;
  }

  static bool? isEmail(String? email) {
    if (email != null) {
      String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
          "\\@" +
          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
          "(" +
          "\\." +
          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
          ")+";
      return new RegExp(p).hasMatch(email);
    }
    return null;
  }

  static String? validateCPassword(String? value, String? password) {
    if (value!.trim().isEmpty) {
      return 'Password can not be empty';
    } else if (value != password) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  static String? validatesBVNNumber(String? value) {
    if (value!.trim().isEmpty) {
      return 'BVN Number can not be empty';
    } else if (RegExp(r"^[0-9]{11}$").hasMatch(value) == false) {
      return 'Invalid BVN Number';
    }

    return null;
  }



  static String? validatePassword(String? value) {
    if (value!.trim().isEmpty) {
      return 'Password can not be empty';
    } else if (value.trim().length < 8) {
      return 'Password can not be less than 8 characters';
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain upper case character";
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain a number";
    } else if (!value.contains(RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+='
        "'"
        ']'))) {
      return "Password must contain a number";
    }

    return null;
  }

  static String? validateRequired(String? value) {
    if (value!.trim().isEmpty) {
      return 'Field can not be empty';
    }

    return null;
  }

  static String? validatePhone234(String? value) {
    if (value!.trim().isEmpty) return 'Phone can not be empty';
    if (value.trim().length != 11) return 'Phone is Invalid';

    return null;
  }




  static String? validateUrl(String? value) {
    if (value!.trim().isEmpty) {
      return "Url cannot be empty";
    } else if (!Uri.parse(value).isAbsolute) {
      return "Invalid URL";
    }
    return null;
  }
}
