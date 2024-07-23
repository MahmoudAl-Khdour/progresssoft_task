import 'package:flutter/material.dart';
import 'package:progresssoft_task/core/utils/constant/app_colors.dart';
import 'package:progresssoft_task/core/utils/constant/app_defaults.dart';

class CustomFormFiled extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? label;
  final String? hint;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final bool isPassword;
  final bool enabled;
  final bool filled;
  final bool readOnly;
  final int? maxLength;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final bool? isEmail;
  final List<IconData>? prefixIcons;
  final FocusNode? focusNode;
  final String? errorText;
  final String? suffixText;
  final TextStyle? suffixStyle;
  final Widget? suffix;
  final Widget? prefix;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final int? minLines;
  final bool autofocus;
  final Color? cursorColor;
  final Color? borderColors;
  final double? borderWidth;
  final Color? fillColor;
  final Color focusBorderColor;
  final Color textColor;
  final bool pressablePrefix;

  const CustomFormFiled({
    super.key,
    this.controller,
    this.contentPadding,
    this.textInputAction,
    this.errorText,
    required this.cursorColor,
    required this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.hint,
    this.onSubmit,
    this.onChange,
    this.onTap,
    required this.isPassword,
    required this.enabled,
    required this.readOnly,
    this.maxLength = 200,
    this.labelStyle,
    this.hintStyle,
    this.prefixText,
    this.prefixStyle,
    this.isEmail,
    this.prefixIcons,
    this.focusNode,
    this.suffixText,
    this.suffixStyle,
    this.suffix,
    this.prefix,
    this.borderRadius,
    this.maxLines = 1,
    required this.autofocus,
    this.borderColors,
    required this.focusBorderColor,
    required this.textColor,
    required this.filled,
    this.fillColor,
    this.minLines,
    this.borderWidth,
    required this.pressablePrefix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      controller: controller,
      cursorColor: cursorColor,
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: validator,
      onChanged: onChange,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      enabled: enabled,
      readOnly: readOnly,
      maxLength: 100,
      maxLines: maxLines,
      minLines: minLines,
      autofocus: autofocus,
      focusNode: focusNode,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
            fontSize: 14,
            color: textColor,
            fontWeight: FontWeight.normal,
          ),
      decoration: InputDecoration(
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
        errorText: errorText,
        errorMaxLines: 2,
        counter: const Offstage(),
        errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
              color: AppColors.appErrorColor,
            ),
        filled: filled,
        fillColor: fillColor ?? Theme.of(context).primaryColor,
        focusColor: Theme.of(context).primaryColor,
        labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
        labelText: label,
        hintText: hint,
        hintStyle: hintStyle,
        suffixText: suffixText,
        suffix: suffix,
        prefix: prefix,
        suffixStyle: suffixStyle,
        prefixStyle: prefixStyle,
        prefixText: prefixText,
        alignLabelWithHint: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: borderColors != null && borderWidth != null
              ? BorderSide(
                  color: borderColors!,
                  width: borderWidth!,
                )
              : BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 0.4,
                ),
          borderRadius: borderRadius ??
              BorderRadius.circular(
                AppDefaults.defaultRightRadius,
              ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: borderColors != null && borderWidth != null
              ? BorderSide(
                  color: borderColors!,
                  width: borderWidth!,
                )
              : BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 0.4,
                ),
          borderRadius: borderRadius ??
              BorderRadius.circular(
                AppDefaults.defaultRightRadius,
              ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
          borderRadius: borderRadius ??
              BorderRadius.circular(
                AppDefaults.defaultRightRadius,
              ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.appErrorColor,
            width: 0.4,
          ),
          borderRadius: borderRadius ??
              BorderRadius.circular(
                AppDefaults.defaultRightRadius,
              ),
        ),
      ),
    );
  }
}
