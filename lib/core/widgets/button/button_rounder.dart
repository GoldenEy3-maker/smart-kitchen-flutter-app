import "package:flutter/widgets.dart";

final class ButtonRounder {
  final BorderRadius? borderRadius;
  final BoxShape? shape;

  ButtonRounder({this.borderRadius, this.shape});

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
    borderRadius: BorderRadius.circular(28),
  );
}
