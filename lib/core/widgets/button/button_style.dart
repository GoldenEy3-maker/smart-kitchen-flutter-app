import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

final class ButtonStyle {
  final Color backgroundColor;
  final Color foregroundColor;

  final BoxBorder? border;
  final double elevation;
  final Color? shadowColor;
  final ButtonStyle? disabled;

  ButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    this.border,
    this.elevation = 0,
    this.shadowColor,
    this.disabled,
  });

  ButtonStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Border? border,
    double? elevation,
    Color? shadowColor,
    ButtonStyle? disabled,
  }) {
    return ButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      border: border ?? this.border,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      disabled: disabled ?? this.disabled,
    );
  }
}

abstract final class ButtonStyles {
  static final ButtonStyle primary = ButtonStyle(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    disabled: ButtonStyle(
      backgroundColor: AppColors.primary.withValues(alpha: 0.3),
      foregroundColor: AppColors.onPrimary,
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

  static final ButtonStyle text = ButtonStyle(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.textPrimary,
  );

  static final ButtonStyle destructive = ButtonStyle(
    backgroundColor: AppColors.danger,
    foregroundColor: AppColors.onDanger,
    disabled: ButtonStyle(
      backgroundColor: AppColors.danger.withValues(alpha: 0.3),
      foregroundColor: AppColors.onDanger,
    ),
  );

  static final ButtonStyle destructiveGhost = ButtonStyle(
    backgroundColor: AppColors.dangerSoft,
    foregroundColor: AppColors.dangerText,
    disabled: ButtonStyle(
      backgroundColor: AppColors.dangerSoft.withValues(alpha: 0.4),
      foregroundColor: AppColors.dangerText.withValues(alpha: 0.4),
    ),
  );

  static final ButtonStyle surface = ButtonStyle(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
  );

  static final ButtonStyle surfaceSelected = ButtonStyle(
    backgroundColor: AppColors.primarySoft,
    foregroundColor: AppColors.textPrimary,
  );
}
