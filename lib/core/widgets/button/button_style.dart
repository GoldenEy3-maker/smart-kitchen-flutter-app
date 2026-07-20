import "package:flutter/widgets.dart";

final class ButtonStyle {
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderRadius? borderRadius;
  final BoxShape? shape;
  final TextStyle? textStyle;
  final BoxBorder? border;
  final double elevation;
  final Color? shadowColor;

  ButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderRadius,
    this.shape,
    this.textStyle,
    this.border,
    this.elevation = 0,
    this.shadowColor,
  });

  ButtonStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    BorderRadius? borderRadius,
    BoxShape? shape,
    Border? border,
    TextStyle? textStyle,
    double? elevation,
    Color? shadowColor,
  }) {
    return ButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      shape: shape ?? this.shape,
      border: border ?? this.border,
      textStyle: textStyle ?? this.textStyle,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }
}
