import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

final class ButtonSize {
  final double minHeight;
  final double minWidth;
  final double maxHeight;
  final double maxWidth;
  final EdgeInsets padding;
  final double fontSize;

  ButtonSize({
    required this.minHeight,
    required this.minWidth,
    required this.maxHeight,
    required this.maxWidth,
    required this.padding,
    this.fontSize = 16,
  });

  ButtonSize copyWith({
    double? minHeight,
    double? minWidth,
    double? maxHeight,
    double? maxWidth,
    EdgeInsets? padding,
    double? fontSize,
  }) {
    return ButtonSize(
      minHeight: minHeight ?? this.minHeight,
      minWidth: minWidth ?? this.minWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      maxWidth: maxWidth ?? this.maxWidth,
      padding: padding ?? this.padding,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}

abstract final class ButtonSizes {
  static final ButtonSize primary = ButtonSize(
    minHeight: 48,
    minWidth: 0,
    maxHeight: double.infinity,
    maxWidth: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: AppSpacing.xLarge,
      vertical: AppSpacing.standard,
    ),
  );

  static final ButtonSize sm = ButtonSize(
    minHeight: 36,
    minWidth: 0,
    maxHeight: double.infinity,
    maxWidth: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: AppSpacing.medium,
      vertical: AppSpacing.small,
    ),
    fontSize: 14,
  );

  static final ButtonSize icon = ButtonSize(
    minHeight: 48,
    minWidth: 48,
    maxHeight: 48,
    maxWidth: 48,
    padding: EdgeInsets.zero,
  );

  static final ButtonSize iconSmall = ButtonSize(
    minHeight: 44,
    minWidth: 44,
    maxHeight: 44,
    maxWidth: 44,
    padding: EdgeInsets.zero,
  );
}
