import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

import "app_input_style.dart";

abstract class AppInputStyles {
  static final AppInputStyle outlined = AppInputStyle(
    fillColor: AppColors.surface,
    borderColor: AppColors.border,
    focusedBorderColor: AppColors.primary,
    prefixIconColor: AppColors.textSecondary,
    hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 16),
  );
}
