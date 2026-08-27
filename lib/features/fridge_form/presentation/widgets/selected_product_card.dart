import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:skeletonizer/skeletonizer.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/units/units.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/domain/entities/entities.dart";

class SelectedProductCard extends StatelessWidget {
  const SelectedProductCard({
    required this.onPressed,
    super.key,
    this.product,
    this.isLoading = false,
    this.invalid = false,
  });

  final ProductWithCategory? product;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool invalid;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final text = context.theme.text;

    final resolvedProduct = isLoading ? ProductWithCategory.loading() : product;
    final hasProduct = resolvedProduct != null;

    if (!hasProduct) {
      return InputButton(
        onPressed: onPressed,
        hintText: l10n.selectOrCreate,
        invalid: invalid,
      );
    }

    final unit = CatalogUnits.resolveLabels(
      context: context,
      unit: CatalogUnits.fromName(resolvedProduct.product.unit),
    ).short;

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
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: colors.surfaceOverlay,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CatalogIcons.fromName(
                        resolvedProduct.product.iconKey,
                      ).icon,
                      color: colors.primary,
                      size: 22,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resolvedProduct.product.name,
                          style: text.labelMd.copyWith(
                            color: colors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          l10n.fridgeFormProductMeta(
                            resolvedProduct.category.label,
                            unit,
                          ),
                          style: text.bodyXs.copyWith(
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
