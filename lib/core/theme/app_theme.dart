import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/theme/app_colors_extension.dart";

import "package:smart_kitchen_flutter_app/core/theme/app_fonts.dart";
import "package:smart_kitchen_flutter_app/core/theme/app_radius.dart";
import "package:smart_kitchen_flutter_app/core/theme/app_spacing.dart";
import "package:smart_kitchen_flutter_app/core/theme/app_text_extension.dart";

class AppTheme {
  static final ThemeData light = _buildThemeData(
    brightness: Brightness.light,
    colors: AppColorsExtension.light,
    text: AppTextExtension.base(),
  );

  static final ThemeData dark = _buildThemeData(
    brightness: Brightness.dark,
    colors: AppColorsExtension.dark,
    text: AppTextExtension.base(),
  );

  static ThemeData _buildThemeData({
    required AppColorsExtension colors,
    required AppTextExtension text,
    required Brightness brightness,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppFonts.inter,
      scaffoldBackgroundColor: colors.bg,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.secondary,
        onSecondary: colors.onPrimary,
        error: colors.danger,
        onError: colors.onDanger,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        outline: colors.border,
      ),
      textTheme: TextTheme(
        bodyMedium: text.bodyMd.copyWith(color: colors.textPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.standard,
          vertical: AppSpacing.medium,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
          borderSide: BorderSide(color: colors.primary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
          borderSide: BorderSide(color: colors.border),
        ),
        prefixIconColor: colors.textSecondary,
        hintStyle: TextStyle(color: colors.textSecondary, fontSize: 16),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.bg,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: text.headingLg.copyWith(color: colors.textPrimary),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colors.surface,
        selectedColor: colors.primary,
        labelStyle: text.labelSm.copyWith(
          color: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colors.onPrimary;
            }
            return colors.textSecondary;
          }),
        ),
        showCheckmark: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          side: BorderSide(color: colors.border),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xLarge),
        ),
        foregroundColor: colors.onPrimary,
        extendedTextStyle: text.labelSm,
        extendedIconLabelSpacing: AppSpacing.small,
        sizeConstraints: const BoxConstraints(minHeight: 48),
        extendedPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xLarge,
          vertical: AppSpacing.standard,
        ),
      ),
      dividerColor: colors.border,
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        modalBarrierColor: colors.overlayScrim,
        surfaceTintColor: Colors.transparent,
      ),
      extensions: [colors, text],
    );
  }
}

extension AppThemeExtension on ThemeData {
  AppColorsExtension get colors {
    final colorsExtension = extension<AppColorsExtension>();
    assert(colorsExtension != null, "AppColorsExtension is not registered");
    return extension<AppColorsExtension>()!;
  }

  AppTextExtension get text {
    final textExtension = extension<AppTextExtension>();
    assert(textExtension != null, "AppTextExtension is not registered");
    return extension<AppTextExtension>()!;
  }
}
