import "package:flutter/material.dart";

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.bg,
    required this.surface,
    required this.surfaceMuted,
    required this.surfaceGlass,
    required this.surfaceFaded,
    required this.surfaceOverlay,
    required this.border,
    required this.borderMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.primary,
    required this.primarySoft,
    required this.primaryText,
    required this.onPrimary,
    required this.primaryEmptyFill,
    required this.primaryEmptyStroke,
    required this.primaryGlow,
    required this.primaryGlowSoft,
    required this.dayActiveSoft,
    required this.secondary,
    required this.secondarySoft,
    required this.secondaryText,
    required this.warning,
    required this.warningSoft,
    required this.warningText,
    required this.danger,
    required this.dangerSoft,
    required this.dangerText,
    required this.onDanger,
    required this.availabilityPartial,
    required this.iconBg,
    required this.shadowColor,
    required this.shadowColorMd,
    required this.shadowColorSegment,
    required this.overlayScrim,
  });

  final Color bg;

  final Color surface;
  final Color surfaceMuted;
  final Color surfaceGlass;
  final Color surfaceFaded;
  final Color surfaceOverlay;

  final Color border;
  final Color borderMuted;

  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  final Color primary;
  final Color primarySoft;
  final Color primaryText;
  final Color onPrimary;
  final Color primaryEmptyFill;
  final Color primaryEmptyStroke;
  final Color primaryGlow;
  final Color primaryGlowSoft;
  final Color dayActiveSoft;

  final Color secondary;
  final Color secondarySoft;
  final Color secondaryText;

  final Color warning;
  final Color warningSoft;
  final Color warningText;

  final Color danger;
  final Color dangerSoft;
  final Color dangerText;
  final Color onDanger;

  final Color availabilityPartial;
  final Color iconBg;

  final Color shadowColor;
  final Color shadowColorMd;
  final Color shadowColorSegment;
  final Color overlayScrim;

  static const AppColorsExtension light = AppColorsExtension(
    bg: Color(0xFFFAF6EF),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF3EDE2),
    surfaceGlass: Color(0xE6FFFFFF),
    surfaceFaded: Color(0x99FFFFFF),
    surfaceOverlay: Color(0xCCFFFFFF),
    border: Color(0xFFEFE7DA),
    borderMuted: Color(0xFFC9BFB0),
    textPrimary: Color(0xFF2B2521),
    textSecondary: Color(0xFF6B645C),
    textMuted: Color(0xFF7A7268),
    primary: Color(0xFF3A8A4E),
    primarySoft: Color(0xFFE0EFE4),
    primaryText: Color(0xFF2D7340),
    onPrimary: Color(0xFFFFFFFF),
    primaryEmptyFill: Color(0x0D3A8A4E),
    primaryEmptyStroke: Color(0x663A8A4E),
    primaryGlow: Color(0x593A8A4E),
    primaryGlowSoft: Color(0x403A8A4E),
    dayActiveSoft: Color(0xFFD4E8D8),
    secondary: Color(0xFFE8863A),
    secondarySoft: Color(0xFFFBEEDF),
    secondaryText: Color(0xFFC05F1A),
    warning: Color(0xFFF0A731),
    warningSoft: Color(0xFFFCF1DC),
    warningText: Color(0xFFB9770E),
    danger: Color(0xFFE05B4E),
    dangerSoft: Color(0xFFFBE7E4),
    dangerText: Color(0xFFC64537),
    onDanger: Color(0xFFFFFFFF),
    availabilityPartial: Color(0xFFC77E2B),
    iconBg: Color(0xFFF3EDE2),
    shadowColor: Color(0x08000000),
    shadowColorMd: Color(0x0F000000),
    shadowColorSegment: Color(0x0D000000),
    overlayScrim: Color(0x802B2521),
  );

  static const AppColorsExtension dark = AppColorsExtension(
    bg: Color(0xFF1A1714),
    surface: Color(0xFF2A2622),
    surfaceMuted: Color(0xFF332F2A),
    surfaceGlass: Color(0xE62A2622),
    surfaceFaded: Color(0x992A2622),
    surfaceOverlay: Color(0xCC2A2622),
    border: Color(0xFF3D3832),
    borderMuted: Color(0xFF5A534A),
    textPrimary: Color(0xFFF5F0E8),
    textSecondary: Color(0xFFA89F94),
    textMuted: Color(0xFF8F877C),
    primary: Color(0xFF4CA662),
    primarySoft: Color(0xFF243528),
    primaryText: Color(0xFF7BC48A),
    onPrimary: Color(0xFFFFFFFF),
    primaryEmptyFill: Color(0x1A4CA662),
    primaryEmptyStroke: Color(0x804CA662),
    primaryGlow: Color(0x664CA662),
    primaryGlowSoft: Color(0x404CA662),
    dayActiveSoft: Color(0xFF2A3F30),
    secondary: Color(0xFFF0A05A),
    secondarySoft: Color(0xFF3D2E1F),
    secondaryText: Color(0xFFE8A05A),
    warning: Color(0xFFF0B84A),
    warningSoft: Color(0xFF3D3420),
    warningText: Color(0xFFE0B45A),
    danger: Color(0xFFE87066),
    dangerSoft: Color(0xFF3D2826),
    dangerText: Color(0xFFF09084),
    onDanger: Color(0xFFFFFFFF),
    availabilityPartial: Color(0xFFE0A04A),
    iconBg: Color(0xFF3A3530),
    shadowColor: Color(0x40000000),
    shadowColorMd: Color(0x59000000),
    shadowColorSegment: Color(0x4D000000),
    overlayScrim: Color(0xB3000000),
  );

  @override
  AppColorsExtension copyWith({
    Color? bg,
    Color? surface,
    Color? surfaceMuted,
    Color? surfaceGlass,
    Color? surfaceFaded,
    Color? surfaceOverlay,
    Color? border,
    Color? borderMuted,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? primary,
    Color? primarySoft,
    Color? primaryText,
    Color? onPrimary,
    Color? primaryEmptyFill,
    Color? primaryEmptyStroke,
    Color? primaryGlow,
    Color? primaryGlowSoft,
    Color? dayActiveSoft,
    Color? secondary,
    Color? secondarySoft,
    Color? secondaryText,
    Color? warning,
    Color? warningSoft,
    Color? warningText,
    Color? danger,
    Color? dangerSoft,
    Color? dangerText,
    Color? onDanger,
    Color? availabilityPartial,
    Color? iconBg,
    Color? shadowColor,
    Color? shadowColorMd,
    Color? shadowColorSegment,
    Color? overlayScrim,
  }) {
    return AppColorsExtension(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      surfaceGlass: surfaceGlass ?? this.surfaceGlass,
      surfaceFaded: surfaceFaded ?? this.surfaceFaded,
      surfaceOverlay: surfaceOverlay ?? this.surfaceOverlay,
      border: border ?? this.border,
      borderMuted: borderMuted ?? this.borderMuted,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      primary: primary ?? this.primary,
      primarySoft: primarySoft ?? this.primarySoft,
      primaryText: primaryText ?? this.primaryText,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryEmptyFill: primaryEmptyFill ?? this.primaryEmptyFill,
      primaryEmptyStroke: primaryEmptyStroke ?? this.primaryEmptyStroke,
      primaryGlow: primaryGlow ?? this.primaryGlow,
      primaryGlowSoft: primaryGlowSoft ?? this.primaryGlowSoft,
      dayActiveSoft: dayActiveSoft ?? this.dayActiveSoft,
      secondary: secondary ?? this.secondary,
      secondarySoft: secondarySoft ?? this.secondarySoft,
      secondaryText: secondaryText ?? this.secondaryText,
      warning: warning ?? this.warning,
      warningSoft: warningSoft ?? this.warningSoft,
      warningText: warningText ?? this.warningText,
      danger: danger ?? this.danger,
      dangerSoft: dangerSoft ?? this.dangerSoft,
      dangerText: dangerText ?? this.dangerText,
      onDanger: onDanger ?? this.onDanger,
      availabilityPartial: availabilityPartial ?? this.availabilityPartial,
      iconBg: iconBg ?? this.iconBg,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowColorMd: shadowColorMd ?? this.shadowColorMd,
      shadowColorSegment: shadowColorSegment ?? this.shadowColorSegment,
      overlayScrim: overlayScrim ?? this.overlayScrim,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      surfaceGlass: Color.lerp(surfaceGlass, other.surfaceGlass, t)!,
      surfaceFaded: Color.lerp(surfaceFaded, other.surfaceFaded, t)!,
      surfaceOverlay: Color.lerp(surfaceOverlay, other.surfaceOverlay, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderMuted: Color.lerp(borderMuted, other.borderMuted, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryEmptyFill: Color.lerp(
        primaryEmptyFill,
        other.primaryEmptyFill,
        t,
      )!,
      primaryEmptyStroke: Color.lerp(
        primaryEmptyStroke,
        other.primaryEmptyStroke,
        t,
      )!,
      primaryGlow: Color.lerp(primaryGlow, other.primaryGlow, t)!,
      primaryGlowSoft: Color.lerp(primaryGlowSoft, other.primaryGlowSoft, t)!,
      dayActiveSoft: Color.lerp(dayActiveSoft, other.dayActiveSoft, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondarySoft: Color.lerp(secondarySoft, other.secondarySoft, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningSoft: Color.lerp(warningSoft, other.warningSoft, t)!,
      warningText: Color.lerp(warningText, other.warningText, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      dangerSoft: Color.lerp(dangerSoft, other.dangerSoft, t)!,
      dangerText: Color.lerp(dangerText, other.dangerText, t)!,
      onDanger: Color.lerp(onDanger, other.onDanger, t)!,
      availabilityPartial: Color.lerp(
        availabilityPartial,
        other.availabilityPartial,
        t,
      )!,
      iconBg: Color.lerp(iconBg, other.iconBg, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      shadowColorMd: Color.lerp(shadowColorMd, other.shadowColorMd, t)!,
      shadowColorSegment: Color.lerp(
        shadowColorSegment,
        other.shadowColorSegment,
        t,
      )!,
      overlayScrim: Color.lerp(overlayScrim, other.overlayScrim, t)!,
    );
  }
}
