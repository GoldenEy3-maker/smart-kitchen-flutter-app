import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";

class SelectedCategoryCard extends StatelessWidget {
  const SelectedCategoryCard({
    super.key,
    this.category,
    required this.onPressed,
  });

  final CategoryWithProductsCount? category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final backgroundColor = category != null
        ? AppColors.primarySoft
        : AppColors.surface;
    final borderColor = category != null ? AppColors.primary : AppColors.border;
    final double borderWidth = category != null ? 1.5 : 1;
    final EdgeInsets contentPadding = category != null
        ? EdgeInsets.all(AppSpacing.medium)
        : AppInputDecoration().shape.contentPadding;
    final iconColor = category != null
        ? AppColors.primary
        : AppColors.textSecondary;
    final List<Widget> content = category != null
        ? [
            Text(
              category!.label,
              style: AppTypography.textTheme.titleMedium!.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              l10n.productsCount(category!.productsCount),
              style: AppTypography.textTheme.bodySmall!.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ]
        : [
            Text(
              l10n.selectOrCreate,
              style: AppTypography.textTheme.bodyLarge!.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ];

    return Material(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.small),
        side: BorderSide(color: borderColor, width: borderWidth),
      ),
      child: InkWell(
        onTap: onPressed,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: Padding(
          padding: contentPadding,
          child: Row(
            spacing: AppSpacing.medium,
            children: [
              if (category != null)
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceOverlay,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CatalogIcon.fromName(category!.iconKey).icon,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                ),
              ),
              Icon(LucideIcons.chevronDown, color: iconColor, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
