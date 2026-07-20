import "package:flutter/material.dart";

import "input_shape.dart";
import "input_shapes.dart";
import "input_style.dart";
import "input_styles.dart";

class Input extends StatelessWidget {
  final Widget? prefixIcon;
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final InputStyle? style;
  final BorderRadius? borderRadius;
  final InputShape? shape;

  const Input({
    super.key,
    this.prefixIcon,
    this.hintText,
    this.controller,
    this.onChanged,
    this.style,
    this.borderRadius,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = style ?? InputStyles.outlined;
    final resolvedShape = shape ?? InputShapes.rectangular;
    final resolvedBorderColor = resolvedStyle.borderColor ?? Colors.transparent;
    final resolvedFocusedBorderColor =
        resolvedStyle.focusedBorderColor ?? Colors.transparent;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: resolvedShape.prefixIconPadding,
                child: prefixIcon,
              )
            : null,
        prefixIconConstraints: BoxConstraints(minWidth: 0),
        prefixIconColor: resolvedStyle.prefixIconColor,
        border: OutlineInputBorder(
          borderRadius: resolvedShape.borderRadius,
          borderSide: BorderSide(color: resolvedBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: resolvedShape.borderRadius,
          borderSide: BorderSide(color: resolvedBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: resolvedShape.borderRadius,
          borderSide: BorderSide(color: resolvedFocusedBorderColor),
        ),
        hintStyle: resolvedStyle.hintStyle,
        contentPadding: resolvedShape.contentPadding,
        constraints: BoxConstraints(
          minHeight: resolvedShape.height,
          maxHeight: resolvedShape.height,
        ),
      ),
    );
  }
}
