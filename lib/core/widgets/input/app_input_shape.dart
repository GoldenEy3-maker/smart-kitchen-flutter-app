import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

final class AppInputShape {
  final double height;
  final BorderRadius borderRadius;
  final EdgeInsets contentPadding;
  final EdgeInsets prefixIconPadding;

  AppInputShape({
    required this.height,
    required this.contentPadding,
    required this.prefixIconPadding,
    required this.borderRadius,
  });

  AppInputShape copyWith({
    double? height,
    BorderRadius? borderRadius,
    EdgeInsets? contentPadding,
    EdgeInsets? prefixIconPadding,
  }) {
    return AppInputShape(
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      prefixIconPadding: prefixIconPadding ?? this.prefixIconPadding,
    );
  }
}

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
