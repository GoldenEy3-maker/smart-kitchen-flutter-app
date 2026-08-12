import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

@immutable
class ButtonStyle {
  const ButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    this.border,
    this.elevation = 0,
    this.shadowColor,
    this.disabled,
  });

  final Color backgroundColor;
  final Color foregroundColor;

  final BoxBorder? border;
  final double elevation;
  final Color? shadowColor;
  final ButtonStyle? disabled;

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

@immutable
final class ButtonStyles {
  const ButtonStyles({required this.context});

  final BuildContext context;

  factory ButtonStyles.of(BuildContext context) =>
      ButtonStyles(context: context);

  AppColorsExtension get _colors => context.theme.colors;

  ButtonStyle get primary => ButtonStyle(
    backgroundColor: _colors.primary,
    foregroundColor: _colors.onPrimary,
    disabled: ButtonStyle(
      backgroundColor: _colors.primary.withValues(alpha: 0.3),
      foregroundColor: _colors.onPrimary,
    ),
  );

  ButtonStyle get secondary => ButtonStyle(
    backgroundColor: _colors.surface,
    foregroundColor: _colors.textPrimary,
    border: Border.all(color: _colors.border, width: 1),
  );

  ButtonStyle get secondarySelected => ButtonStyle(
    backgroundColor: _colors.primarySoft,
    foregroundColor: _colors.primary,
    border: Border.all(color: _colors.primary, width: 1.5),
  );

  ButtonStyle get secondaryDanger => ButtonStyle(
    backgroundColor: _colors.surface,
    foregroundColor: _colors.dangerText,
    border: Border.all(color: _colors.danger, width: 1.5),
  );

  ButtonStyle get ghost => ButtonStyle(
    backgroundColor: _colors.primarySoft,
    foregroundColor: _colors.primaryText,
  );

  ButtonStyle get text => ButtonStyle(
    backgroundColor: Colors.transparent,
    foregroundColor: _colors.textPrimary,
  );

  ButtonStyle get destructive => ButtonStyle(
    backgroundColor: _colors.danger,
    foregroundColor: _colors.onDanger,
    disabled: ButtonStyle(
      backgroundColor: _colors.danger.withValues(alpha: 0.3),
      foregroundColor: _colors.onDanger,
    ),
  );

  ButtonStyle get destructiveGhost => ButtonStyle(
    backgroundColor: _colors.dangerSoft,
    foregroundColor: _colors.dangerText,
    disabled: ButtonStyle(
      backgroundColor: _colors.dangerSoft.withValues(alpha: 0.4),
      foregroundColor: _colors.dangerText.withValues(alpha: 0.4),
    ),
  );

  ButtonStyle get surface => ButtonStyle(
    backgroundColor: _colors.surface,
    foregroundColor: _colors.textPrimary,
  );

  ButtonStyle get surfaceSelected => ButtonStyle(
    backgroundColor: _colors.primarySoft,
    foregroundColor: _colors.textPrimary,
  );
}
