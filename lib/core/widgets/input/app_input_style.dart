import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

@immutable
class AppInputStyle {
  const AppInputStyle({
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.hintStyle,
    this.prefixIconColor,
  });

  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final TextStyle? hintStyle;
  final Color? prefixIconColor;

  AppInputStyle copyWith({
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    TextStyle? hintStyle,
    Color? prefixIconColor,
  }) => AppInputStyle(
    fillColor: fillColor ?? this.fillColor,
    borderColor: borderColor ?? this.borderColor,
    focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
    errorBorderColor: errorBorderColor ?? this.errorBorderColor,
    hintStyle: hintStyle ?? this.hintStyle,
    prefixIconColor: prefixIconColor ?? this.prefixIconColor,
  );
}

@immutable
final class AppInputStyles {
  const AppInputStyles({required this.context});

  final BuildContext context;

  factory AppInputStyles.of(BuildContext context) =>
      AppInputStyles(context: context);

  AppColorsExtension get _colors => context.theme.colors;

  AppTextExtension get _text => context.theme.text;

  AppInputStyle get outlined => AppInputStyle(
    fillColor: _colors.surface,
    borderColor: _colors.border,
    focusedBorderColor: _colors.primary,
    errorBorderColor: _colors.danger,
    prefixIconColor: _colors.textSecondary,
    hintStyle: _text.bodySm.copyWith(color: _colors.textSecondary),
  );
}
