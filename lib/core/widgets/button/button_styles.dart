import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

import "button_style.dart";

abstract final class ButtonStyles {
  static ButtonStyle get primary => ButtonStyle(
    backgroundColor: AppColors.primary,
    borderRadius: BorderRadius.circular(28),
    foregroundColor: AppColors.onPrimary,
    textStyle: AppTypography.textTheme.labelMedium!.copyWith(
      color: AppColors.onPrimary,
      fontSize: 16,
    ),
  );

  static ButtonStyle get secondary => ButtonStyle(
    backgroundColor: AppColors.surface,
    shape: BoxShape.circle,
    foregroundColor: AppColors.textPrimary,
    border: Border.all(color: AppColors.border, width: 1),
  );
}
