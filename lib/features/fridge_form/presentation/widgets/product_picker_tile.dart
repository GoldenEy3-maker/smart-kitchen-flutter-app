import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/units/units.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/domain/entities/entities.dart";

class ProductPickerTile extends StatelessWidget {
  const ProductPickerTile({
    required this.product,
    required this.onPressed,
    super.key,
    this.selected = false,
  });

  static const double height = 68;

  final ProductWithCategory product;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final text = context.theme.text;

    final backgroundColor = selected ? colors.primarySoft : colors.surface;
    final unit = CatalogUnits.resolveLabels(
      context: context,
      unit: CatalogUnits.fromName(product.product.unit),
    ).short;

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
                    CatalogIcons.fromName(product.product.iconKey).icon,
                    color: colors.textSecondary,
                    size: 18,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.product.name,
                        style: text.labelMd.copyWith(color: colors.textPrimary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        l10n.fridgeFormProductMeta(
                          product.category.label,
                          unit,
                        ),
                        style: text.bodyXs.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
