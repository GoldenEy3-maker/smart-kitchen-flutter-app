import "package:flutter/material.dart";

import "app_colors.dart";
import "app_fonts.dart";
import "app_radius.dart";
import "app_spacing.dart";
import "app_typography.dart";

class AppTheme {
  const AppTheme();

  ThemeData get lightTheme => ThemeData(
    fontFamily: AppFonts.inter,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      outline: AppColors.border,
    ),
    textTheme: AppTypography.textTheme,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.large,
        vertical: AppSpacing.medium,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
        borderSide: BorderSide(color: AppColors.border),
      ),
      prefixIconColor: AppColors.textSecondary,
      hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 16),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.bg,
      foregroundColor: AppColors.textPrimary,
      surfaceTintColor: Colors.transparent,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surface,
      selectedColor: AppColors.primary,
      // color: WidgetStateColor.resolveWith((states) {
      //   if (states.contains(WidgetState.selected)) {
      //     return AppColors.onPrimary;
      //   }

      //   return AppColors.textSecondary;
      // }),
      // padding: EdgeInsets.symmetric(horizontal: AppSpacing.standard),
      // labelPadding: EdgeInsets.symmetric(horizontal: AppSpacing.standard),
      labelStyle: AppTypography.textTheme.labelMedium!.copyWith(
        color: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.onPrimary;
          }

          return AppColors.textSecondary;
        }),
      ),
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
        side: BorderSide(color: AppColors.border),
      ),
    ),
  );
}
