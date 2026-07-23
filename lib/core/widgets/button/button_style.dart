import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

final class ButtonStyle {
  final Color backgroundColor;
  final Color foregroundColor;

  final TextStyle? textStyle;
  final BoxBorder? border;
  final double elevation;
  final Color? shadowColor;

  ButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    this.textStyle,
    this.border,
    this.elevation = 0,
    this.shadowColor,
  });

  ButtonStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,

    Border? border,
    TextStyle? textStyle,
    double? elevation,
    Color? shadowColor,
  }) {
    return ButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      border: border ?? this.border,
      textStyle: textStyle ?? this.textStyle,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }
}

abstract final class ButtonStyles {
  static final ButtonStyle primary = ButtonStyle(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    textStyle: AppTypography.textTheme.labelMedium!.copyWith(
      color: AppColors.onPrimary,
      fontSize: 16,
    ),
  );

  static final ButtonStyle secondary = ButtonStyle(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    border: Border.all(color: AppColors.border, width: 1),
  );

  static final ButtonStyle secondarySelected = ButtonStyle(
    backgroundColor: AppColors.primarySoft,
    foregroundColor: AppColors.primary,
    border: Border.all(color: AppColors.primary, width: 1.5),
  );

  static final ButtonStyle ghost = ButtonStyle(
    backgroundColor: AppColors.primarySoft,
    foregroundColor: AppColors.primaryText,
  );
}
