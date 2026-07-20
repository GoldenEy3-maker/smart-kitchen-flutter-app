import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

import "button_size.dart";

abstract final class ButtonSizes {
  static ButtonSize get primary => ButtonSize(
    minHeight: 48,
    minWidth: 0,
    padding: EdgeInsets.symmetric(
      horizontal: AppSpacing.xLarge,
      vertical: AppSpacing.standard,
    ),
  );

  static ButtonSize get icon =>
      ButtonSize(minHeight: 48, minWidth: 48, padding: EdgeInsets.zero);

  static ButtonSize get iconSmall =>
      ButtonSize(minHeight: 44, minWidth: 44, padding: EdgeInsets.zero);
}
