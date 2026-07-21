import "package:flutter/widgets.dart";

class AppInputStyle {
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final TextStyle? hintStyle;
  final Color? prefixIconColor;

  AppInputStyle({
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.hintStyle,
    this.prefixIconColor,
  });

  AppInputStyle copyWith({
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    TextStyle? hintStyle,
    Color? prefixIconColor,
  }) => AppInputStyle(
    fillColor: fillColor ?? this.fillColor,
    borderColor: borderColor ?? this.borderColor,
    focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
    hintStyle: hintStyle ?? this.hintStyle,
    prefixIconColor: prefixIconColor ?? this.prefixIconColor,
  );
}
