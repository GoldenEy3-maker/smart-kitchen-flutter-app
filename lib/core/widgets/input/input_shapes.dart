import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

import "input_shape.dart";

abstract class InputShapes {
  static InputShape get circular => InputShape(
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

  static InputShape get rectangular => InputShape(
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

  static InputShape get rectangularSmall => InputShape(
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
