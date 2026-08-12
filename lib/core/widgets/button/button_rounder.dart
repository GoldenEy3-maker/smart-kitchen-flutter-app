import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/app_radius.dart";

@immutable
class ButtonRounder {
  const ButtonRounder({this.borderRadius, this.shape});

  final BorderRadius? borderRadius;
  final BoxShape? shape;

  ButtonRounder copyWith({BorderRadius? borderRadius, BoxShape? shape}) {
    return ButtonRounder(
      borderRadius: borderRadius ?? this.borderRadius,
      shape: shape ?? this.shape,
    );
  }
}

abstract final class ButtonRounders {
  static final ButtonRounder circle = ButtonRounder(shape: BoxShape.circle);
  static final ButtonRounder rectangular = ButtonRounder(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(AppRadius.xLarge),
  );
  static final ButtonRounder rectangularSm = ButtonRounder(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(AppRadius.small),
  );
}
