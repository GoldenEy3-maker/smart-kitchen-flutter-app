import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/features/product_form/domain/entities/entities.dart";

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    required this.category,
    required this.onPressed,
    required this.onEditPressed,
    required this.onDeletePressed,
    super.key,
    this.selected = false,
  });

  static const double height = 68;

  final CategoryWithProductsCount category;
  final bool selected;
  final VoidCallback onPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final text = context.theme.text;

    final backgroundColor = selected ? colors.primarySoft : colors.surface;
    final buttonStyles = ButtonStyles.of(context);

    return AnimatedContainer(
      duration: AppDuration.main,
      curve: Curves.easeInOut,
      constraints: const BoxConstraints(minHeight: height),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: InkWell(
          onTap: onPressed,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
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
                    color: colors.iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CatalogIcons.fromName(category.iconKey).icon,
                    color: colors.textSecondary,
                    size: 18,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.label,
                        style: text.labelMd.copyWith(color: colors.textPrimary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        l10n.productsCount(category.productsCount),
                        style: text.bodyXs.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Button(
                      style: buttonStyles.text,
                      size: ButtonSizes.iconSmall,
                      onPressed: onEditPressed,
                      child: Icon(
                        LucideIcons.pencil,
                        size: 18,
                        color: colors.textSecondary,
                      ),
                    ),
                    Button(
                      style: buttonStyles.text,
                      size: ButtonSizes.iconSmall,
                      onPressed: onDeletePressed,
                      child: Icon(
                        LucideIcons.trash2,
                        size: 18,
                        color: colors.dangerText,
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
