import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

import "app_input_shape.dart";

abstract class AppInputShapes {
  static final AppInputShape circular = AppInputShape(
    height: 42,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSpacing.standard,
      vertical: AppSpacing.medium,
    ),
    prefixIconPadding: EdgeInsets.only(
      right: AppSpacing.xSmall,
      left: AppSpacing.large,
    ),
    borderRadius: BorderRadius.circular(AppRadius.large),
  );

  static final AppInputShape rectangular = AppInputShape(
    height: 46,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSpacing.large,
      vertical: AppSpacing.standard,
    ),
    prefixIconPadding: EdgeInsets.only(
      right: AppSpacing.xSmall,
      left: AppSpacing.large,
    ),
    borderRadius: BorderRadius.circular(AppRadius.small),
  );

  static final AppInputShape rectangularSmall = AppInputShape(
    height: 44,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSpacing.standard,
      vertical: AppSpacing.medium,
    ),
    prefixIconPadding: EdgeInsets.only(
      right: AppSpacing.xSmall,
      left: AppSpacing.large,
    ),
    borderRadius: BorderRadius.circular(AppRadius.xSmall),
  );
}
