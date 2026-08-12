import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:skeletonizer/skeletonizer.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";
import "package:smart_kitchen_flutter_app/features/product_form/domain/entities/entities.dart";

class SelectedCategoryCard extends StatelessWidget {
  const SelectedCategoryCard({
    super.key,
    this.category,
    required this.onPressed,
    this.isLoading = false,
    this.invalid = false,
  });

  final CategoryWithProductsCount? category;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool invalid;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final resolvedCategory = isLoading
        ? CategoryWithProductsCount.loading
        : category;
    final hasCategory = resolvedCategory != null;

    if (!hasCategory) {
      return InputButton(
        onPressed: onPressed,
        hintText: l10n.selectOrCreate,
        invalid: invalid,
      );
    }

    return Skeletonizer(
      enabled: isLoading,
      child: Skeleton.leaf(
        child: Material(
          color: colors.primarySoft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
            side: BorderSide(color: colors.primary, width: 1.5),
          ),
          child: InkWell(
            onTap: onPressed,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.medium),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Row(
                spacing: AppSpacing.medium,
                children: [
                  if (hasCategory)
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: colors.surfaceOverlay,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CatalogIcons.fromName(resolvedCategory.iconKey).icon,
                        color: colors.primary,
                        size: 22,
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resolvedCategory.label,
                          style: AppTypography.textTheme.titleMedium!.copyWith(
                            color: colors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          l10n.productsCount(resolvedCategory.productsCount),
                          style: AppTypography.textTheme.bodySmall!.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    LucideIcons.chevronDown,
                    color: colors.primary,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
