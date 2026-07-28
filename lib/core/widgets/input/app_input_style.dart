import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

final class AppInputStyle {
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final TextStyle? hintStyle;
  final Color? prefixIconColor;

  AppInputStyle({
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.hintStyle,
    this.prefixIconColor,
  });

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

abstract final class AppInputStyles {
  static final AppInputStyle outlined = AppInputStyle(
    fillColor: AppColors.surface,
    borderColor: AppColors.border,
    focusedBorderColor: AppColors.primary,
    errorBorderColor: AppColors.danger,
    prefixIconColor: AppColors.textSecondary,
    hintStyle: AppTypography.textTheme.bodyLarge!.copyWith(
      color: AppColors.textSecondary,
    ),
  );
}
