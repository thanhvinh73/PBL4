import 'package:client/shared/extensions/string_ext.dart';
import 'package:client/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

typedef ValidatorCallback = String? Function(String?);
typedef TypeValidation<T> = String? Function(T? data);

class AppTextFormField extends FormField<String> {
  final List<TypeValidation<String?>> validations;
  final void Function(FormFieldState<String>)? validationCall;
  final EdgeInsets padding;
  final String? label;
  final TextEditingController? controller;
  final String? placeholder;
  final Function(String) onchanged;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String? initValue;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final int? maxLines;
  final int? minLines;
  final List<ValidatorCallback> validators;
  final bool isRequired;

  AppTextFormField(
      {super.key,
      required this.validations,
      this.validationCall,
      this.label,
      this.controller,
      this.validators = const [],
      this.padding = EdgeInsets.zero,
      this.placeholder,
      required this.onchanged,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.initValue,
      this.obscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.textStyle,
      this.maxLines = 1,
      this.minLines = 1,
      this.isRequired = true})
      : super(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (currentData) {
              return validations
                  .map((validateFunc) => validateFunc(currentData))
                  .firstWhere((element) => element.isNotEmptyOrNull,
                      orElse: () => null);
            },
            builder: (validator) {
              validationCall?.call(validator);
              return AppTextField(
                initValue: initValue,
                label: label,
                controller: controller,
                padding: padding,
                placeholder: placeholder,
                textInputAction: textInputAction,
                textInputType: textInputType,
                obscureText: obscureText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                textStyle: textStyle,
                maxLines: maxLines,
                minLines: minLines,
                onChanged: (_) {
                  validator.didChange(_);
                  onchanged.call(_);
                },
                isRequired: isRequired,
                errorLabel: !validator.isValid ? validator.errorText : null,
              );
            });
}
