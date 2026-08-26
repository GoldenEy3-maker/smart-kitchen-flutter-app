import "package:flutter/material.dart";

import "package:smart_kitchen_flutter_app/core/theme/app_fonts.dart";

class AppTextExtension extends ThemeExtension<AppTextExtension> {
  AppTextExtension({
    required this.heading2xl,
    required this.headingXl,
    required this.headingLg,
    required this.bodyMd,
    required this.bodySm,
    required this.bodyXs,
    required this.labelMd,
    required this.labelSm,
    required this.labelXs,
    required this.overline,
  });

  AppTextExtension.base()
    : this(
        heading2xl: const TextStyle(
          fontFamily: AppFonts.manrope,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),

        headingXl: const TextStyle(
          fontFamily: AppFonts.manrope,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),

        headingLg: const TextStyle(
          fontFamily: AppFonts.manrope,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),

        bodyMd: const TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),

        bodySm: const TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),

        bodyXs: const TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),

        labelMd: const TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),

        labelSm: const TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        labelXs: const TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),

        overline: const TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      );

  final TextStyle heading2xl;
  final TextStyle headingXl;
  final TextStyle headingLg;
  final TextStyle bodyMd;
  final TextStyle bodySm;
  final TextStyle bodyXs;
  final TextStyle labelMd;
  final TextStyle labelSm;
  final TextStyle labelXs;
  final TextStyle overline;

  @override
  AppTextExtension copyWith({
    TextStyle? heading2xl,
    TextStyle? headingXl,
    TextStyle? headingLg,
    TextStyle? bodyMd,
    TextStyle? bodySm,
    TextStyle? bodyXs,
    TextStyle? labelMd,
    TextStyle? labelSm,
    TextStyle? labelXs,
    TextStyle? overline,
  }) => AppTextExtension(
    heading2xl: heading2xl ?? this.heading2xl,
    headingXl: headingXl ?? this.headingXl,
    headingLg: headingLg ?? this.headingLg,
    bodyMd: bodyMd ?? this.bodyMd,
    bodySm: bodySm ?? this.bodySm,
    bodyXs: bodyXs ?? this.bodyXs,
    labelMd: labelMd ?? this.labelMd,
    labelSm: labelSm ?? this.labelSm,
    labelXs: labelXs ?? this.labelXs,
    overline: overline ?? this.overline,
  );

  @override
  ThemeExtension<AppTextExtension> lerp(
    covariant ThemeExtension<AppTextExtension>? other,
    double t,
  ) {
    if (other is! AppTextExtension) {
      return this;
    }
    return AppTextExtension(
      heading2xl: TextStyle.lerp(heading2xl, other.heading2xl, t)!,
      headingXl: TextStyle.lerp(headingXl, other.headingXl, t)!,
      headingLg: TextStyle.lerp(headingLg, other.headingLg, t)!,
      bodyMd: TextStyle.lerp(bodyMd, other.bodyMd, t)!,
      bodySm: TextStyle.lerp(bodySm, other.bodySm, t)!,
      bodyXs: TextStyle.lerp(bodyXs, other.bodyXs, t)!,
      labelMd: TextStyle.lerp(labelMd, other.labelMd, t)!,
      labelSm: TextStyle.lerp(labelSm, other.labelSm, t)!,
      labelXs: TextStyle.lerp(labelXs, other.labelXs, t)!,
      overline: TextStyle.lerp(overline, other.overline, t)!,
    );
  }
}
