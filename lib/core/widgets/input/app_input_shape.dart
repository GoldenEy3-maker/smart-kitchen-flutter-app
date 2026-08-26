import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

@immutable
class AppInputShape {
  const AppInputShape({
    required this.height,
    required this.contentPadding,
    required this.prefixIconPadding,
    required this.borderRadius,
  });

  final double height;
  final BorderRadius borderRadius;
  final EdgeInsets contentPadding;
  final EdgeInsets prefixIconPadding;

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

abstract final class AppInputShapes {
  static final AppInputShape circular = AppInputShape(
    height: 42,
    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.standard),
    prefixIconPadding: const EdgeInsets.only(
      right: AppSpacing.xSmall,
      left: AppSpacing.large,
    ),
    borderRadius: BorderRadius.circular(AppRadius.large),
  );

  static final AppInputShape rectangular = AppInputShape(
    height: 46,
    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
    prefixIconPadding: const EdgeInsets.only(
      right: AppSpacing.xSmall,
      left: AppSpacing.large,
    ),
    borderRadius: BorderRadius.circular(AppRadius.medium),
  );

  static final AppInputShape rectangularSmall = AppInputShape(
    height: 44,
    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.standard),
    prefixIconPadding: const EdgeInsets.only(
      right: AppSpacing.xSmall,
      left: AppSpacing.large,
    ),
    borderRadius: BorderRadius.circular(AppRadius.small),
  );
}
