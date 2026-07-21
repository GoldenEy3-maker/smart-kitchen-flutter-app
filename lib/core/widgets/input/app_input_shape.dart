import "package:flutter/widgets.dart";

class AppInputShape {
  final double height;
  final BorderRadius borderRadius;
  final EdgeInsets contentPadding;
  final EdgeInsets prefixIconPadding;

  AppInputShape({
    required this.height,
    required this.contentPadding,
    required this.prefixIconPadding,
    required this.borderRadius,
  });
}
