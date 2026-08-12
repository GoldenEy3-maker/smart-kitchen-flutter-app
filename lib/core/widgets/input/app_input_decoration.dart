import "package:flutter/material.dart";

import "app_input_shape.dart";
import "app_input_style.dart";

class AppInputDecoration {
  AppInputDecoration({
    this.context,
    this.prefixIcon,
    this.hintText = "",
    this.invalid = false,
    AppInputStyle? style,
    AppInputShape? shape,
  }) : assert(
         style == null && context != null,
         "Either style or context must be provided",
       ),
       style = style ?? AppInputStyles.of(context!).outlined,
       shape = shape ?? AppInputShapes.rectangular;

  final BuildContext? context;
  final Widget? prefixIcon;
  final String? hintText;
  final bool invalid;
  final AppInputStyle style;
  final AppInputShape shape;

  AppInputDecoration copyWith({
    Widget? prefixIcon,
    String? hintText,
    bool? invalid,
    AppInputStyle? style,
    AppInputShape? shape,
  }) {
    return AppInputDecoration(
      context: context,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      hintText: hintText ?? this.hintText,
      invalid: invalid ?? this.invalid,
      style: style ?? this.style,
      shape: shape ?? this.shape,
    );
  }

  Color get errorBorderColor => style.errorBorderColor ?? Colors.transparent;

  Color get borderColor =>
      invalid ? errorBorderColor : style.borderColor ?? Colors.transparent;

  InputDecoration toInputDecoration() {
    final focusedBorderColor = invalid
        ? errorBorderColor
        : style.focusedBorderColor ?? Colors.transparent;
    final border = OutlineInputBorder(
      borderRadius: shape.borderRadius,
      borderSide: BorderSide(color: borderColor),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: shape.borderRadius,
      borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: shape.borderRadius,
      borderSide: BorderSide(color: errorBorderColor),
    );

    return InputDecoration(
      filled: true,
      fillColor: style.fillColor,
      hintText: hintText,
      hintStyle: style.hintStyle,
      prefixIcon: prefixIcon != null
          ? Padding(padding: shape.prefixIconPadding, child: prefixIcon)
          : null,
      prefixIconConstraints: const BoxConstraints(minWidth: 0),
      prefixIconColor: style.prefixIconColor,
      border: border,
      enabledBorder: border,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      contentPadding: shape.contentPadding,
      constraints: BoxConstraints(
        minHeight: shape.height,
        maxHeight: shape.height,
      ),
    );
  }
}
