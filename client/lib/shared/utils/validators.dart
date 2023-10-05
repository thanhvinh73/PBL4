import 'dart:io';

import 'package:client/generated/translations.g.dart';
import 'package:client/shared/extensions/string_ext.dart';
import 'package:easy_localization/easy_localization.dart';

class Validators {
  static String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);

    if (value != null && value.isNotEmpty) {
      if (regex.hasMatch(value)) {
        return null;
      } else {
        return tr(LocaleKeys.Error_InvalidEmail);
      }
    }
    return tr(LocaleKeys.Error_PleaseEnterEmail);
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.Error_PasswordEmpty);
    } else if (value.length < 4) {
      return tr(LocaleKeys.Error_PasswordLength);
    } else if (!value.contains(RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])'))) {
      return tr(LocaleKeys.Error_PasswordFormat);
    }
    return null;
  }

  static String? validateConfirmPassword(String? pwd, String? confirmPwd) {
    if (confirmPwd == null || confirmPwd.trim().isEmpty) {
      return tr(LocaleKeys.Error_FieldEmpty);
    } else if (confirmPwd.length < 8) {
      return tr(LocaleKeys.Error_MinLength);
    } else if (confirmPwd.length > 32) {
      return tr(LocaleKeys.Error_MaxLength);
    } else if (!confirmPwd
        .contains(RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])'))) {
      return tr(LocaleKeys.Error_PasswordFormat);
    } else if (pwd != confirmPwd) {
      return tr(LocaleKeys.Error_PasswordConfirmNotMatch);
    }
    return null;
  }

  static String? validateNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(LocaleKeys.Error_FieldEmpty);
    }
    return null;
  }

  static String? validateNotEmptyOrNull<T>(T param, {String? errorCode}) {
    bool isEmptyOrNull = [
      param is String && param.isEmptyOrNull,
      param is List && param.isEmpty
    ].any((element) => element);
    return isEmptyOrNull ? errorCode ?? tr(LocaleKeys.Error_FieldEmpty) : null;
  }

  static String? validateFileNotNull(File? param, {String? errorCode}) {
    return param == null ? errorCode ?? tr(LocaleKeys.Error_FieldEmpty) : null;
  }

  static String? validateUrl(String? param, {String? errorCode}) {
    RegExp linkRegExp = RegExp(
        r'([Hh][Tt][Tt][Pp]:\/\/|[Hh][Tt][Tt][Pp][Ss]:\/\/|[Ff]tp:\/\/|^|\s)[\w/\-?=%.]+\.[-a-zA-Z0-9@:%_\+.~#?&//=]+');
    return param.isNotEmptyOrNull && linkRegExp.stringMatch(param!) == param
        ? null
        : 'Link not detected';
  }

  static String? validateDateTimeFormat(String? text) {
    try {
      if (text.isNotEmptyOrNull &&
          RegExp(r'^\d{4}/\d{1,2}/\d{1,2}$').hasMatch(text!) &&
          [
            int.parse(text.split('/')[1]) <= 12,
            int.parse(text.split('/')[1]) > 0,
            int.parse(text.split('/')[2]) <= 31,
            int.parse(text.split('/')[2]) > 0,
            DateFormat('yyyy/MM/dd').parse(text) != null
          ].every((element) => element)) {
        return null;
      } else {
        throw 'Format is not correct';
      }
    } catch (err) {
      return tr(LocaleKeys.Error_InvalidDateTime);
    }
  }
}
