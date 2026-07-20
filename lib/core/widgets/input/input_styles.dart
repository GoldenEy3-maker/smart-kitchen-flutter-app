import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

import "input_style.dart";

abstract class InputStyles {
  static InputStyle get outlined => InputStyle(
    fillColor: AppColors.surface,
    borderColor: AppColors.border,
    focusedBorderColor: AppColors.primary,
    prefixIconColor: AppColors.textSecondary,
    hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 16),
  );
}
