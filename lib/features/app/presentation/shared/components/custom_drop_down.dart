import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:progresssoft_task/core/utils/constant/app_colors.dart';
import 'package:progresssoft_task/core/utils/constant/app_defaults.dart';

class CustomDropDown extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldValidator<dynamic>? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? label;
  final String? hint;
  final dynamic value;
  final void Function(dynamic)? onChange;
  final bool filled;
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
  final bool autofocus;
  final Color? borderColors;
  final double? borderWidth;
  final Color? fillColor;
  final Color focusBorderColor;
  final Color textColor;
  final bool pressablePrefix;
  final Color dropDownColor;
  final double? maxHeight;

  const CustomDropDown({
    super.key,
    this.value,
    this.validator,
    required this.items,
    this.contentPadding,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.hint,
    this.onChange,
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
    required this.autofocus,
    this.borderColors,
    required this.focusBorderColor,
    required this.textColor,
    required this.filled,
    this.fillColor,
    this.borderWidth,
    required this.pressablePrefix,
    required this.dropDownColor,
    this.maxHeight = 180,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      validator: validator,
      value: value,
      items: items,
      onChanged: onChange,
      autofocus: autofocus,
      focusNode: focusNode,
      iconStyleData: IconStyleData(
        iconEnabledColor: Theme.of(context).primaryColor,
        iconDisabledColor: Theme.of(context).primaryColor,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: maxHeight,
        decoration: BoxDecoration(
          color: dropDownColor,
        ),
      ),
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
          borderSide: const BorderSide(
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
