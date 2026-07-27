import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:skeletonizer/skeletonizer.dart";
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
    this.isLoading = false,
  });

  final CategoryWithProductsCount? category;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final resolvedCategory = isLoading
        ? CategoryWithProductsCount.loading
        : category;
    final hasCategory = resolvedCategory != null;
    final backgroundColor = hasCategory
        ? AppColors.primarySoft
        : AppColors.surface;
    final borderColor = hasCategory ? AppColors.primary : AppColors.border;
    final double borderWidth = hasCategory ? 1.5 : 1;
    final EdgeInsets contentPadding = hasCategory
        ? EdgeInsets.all(AppSpacing.medium)
        : AppInputDecoration().shape.contentPadding;
    final iconColor = hasCategory ? AppColors.primary : AppColors.textSecondary;
    final List<Widget> content = hasCategory
        ? [
            Text(
              resolvedCategory.label,
              style: AppTypography.textTheme.titleMedium!.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              l10n.productsCount(resolvedCategory.productsCount),
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

    return Skeletonizer(
      enabled: isLoading,
      child: Skeleton.leaf(
        child: Material(
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
                  if (hasCategory)
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceOverlay,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CatalogIcon.fromName(resolvedCategory.iconKey).icon,
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
        ),
      ),
    );
  }
}
