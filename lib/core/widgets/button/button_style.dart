import "package:flutter/widgets.dart";

final class ButtonStyle {
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderRadius? borderRadius;
  final BoxShape? shape;
  final TextStyle? textStyle;
  final BoxBorder? border;

  ButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderRadius,
    this.shape,
    this.textStyle,
    this.border,
  });

  ButtonStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    BorderRadius? borderRadius,
    BoxShape? shape,
    Border? border,
    TextStyle? textStyle,
  }) {
    return ButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      shape: shape ?? this.shape,
      border: border ?? this.border,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
