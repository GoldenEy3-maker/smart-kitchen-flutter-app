import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
    this.selected = false,
    required this.onPressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  static const double height = 68;

  final CategoryWithProductsCount category;
  final bool selected;
  final VoidCallback onPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final backgroundColor = selected
        ? AppColors.primarySoft
        : AppColors.surface;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(AppRadius.xSmall),
      ),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xSmall),
        ),
        child: InkWell(
          onTap: onPressed,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xSmall),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.small,
              vertical: AppSpacing.medium,
            ),
            child: Row(
              spacing: AppSpacing.medium,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CatalogIcons.fromName(category.iconKey).icon,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.label,
                        style: AppTypography.textTheme.titleMedium!.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        l10n.productsCount(category.productsCount),
                        style: AppTypography.textTheme.bodySmall!.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Button(
                      style: ButtonStyles.text,
                      size: ButtonSizes.iconSmall,
                      onPressed: onEditPressed,
                      child: Icon(
                        LucideIcons.pencil,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Button(
                      style: ButtonStyles.text,
                      size: ButtonSizes.iconSmall,
                      onPressed: onDeletePressed,
                      child: Icon(
                        LucideIcons.trash2,
                        size: 18,
                        color: AppColors.dangerText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
