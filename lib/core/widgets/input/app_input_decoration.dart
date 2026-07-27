import "package:flutter/material.dart";

import "app_input_shape.dart";
import "app_input_style.dart";

class AppInputDecoration {
  final Widget? prefixIcon;
  final String? hintText;
  final AppInputStyle style;
  final AppInputShape shape;

  AppInputDecoration({
    this.prefixIcon,
    this.hintText = "",
    AppInputStyle? style,
    AppInputShape? shape,
  }) : style = style ?? AppInputStyles.outlined,
       shape = shape ?? AppInputShapes.rectangular;

  AppInputDecoration copyWith({
    Widget? prefixIcon,
    String? hintText,
    AppInputStyle? style,
    AppInputShape? shape,
  }) {
    return AppInputDecoration(
      prefixIcon: prefixIcon ?? this.prefixIcon,
      hintText: hintText ?? this.hintText,
      style: style ?? this.style,
      shape: shape ?? this.shape,
    );
  }

  InputDecoration toInputDecoration() {
    final borderColor = style.borderColor ?? Colors.transparent;
    final focusedBorderColor = style.focusedBorderColor ?? Colors.transparent;
    final border = OutlineInputBorder(
      borderRadius: shape.borderRadius,
      borderSide: BorderSide(color: borderColor),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: shape.borderRadius,
      borderSide: BorderSide(color: focusedBorderColor),
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
      contentPadding: shape.contentPadding,
      constraints: BoxConstraints(
        minHeight: shape.height,
        maxHeight: shape.height,
      ),
    );
  }
}
