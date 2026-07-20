import "package:flutter/widgets.dart";

class InputShape {
  final double height;
  final BorderRadius borderRadius;
  final EdgeInsets contentPadding;
  final EdgeInsets prefixIconPadding;

  InputShape({
    required this.height,
    required this.contentPadding,
    required this.prefixIconPadding,
    required this.borderRadius,
  });
}
