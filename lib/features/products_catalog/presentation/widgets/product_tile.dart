import "package:flutter/material.dart";
import "package:skeletonizer/skeletonizer.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/icons/catalog_icons.dart";
import "package:smart_kitchen_flutter_app/core/units/units.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
    required this.onPressed,
  });

  final Product product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final text = context.theme.text;

    return Material(
      color: colors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.medium)),
        side: Border.all(color: colors.border).top,
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.medium)),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.medium)),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.medium),
          child: Row(
            children: [
              Skeleton.leaf(
                child: Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: colors.iconBg,
                    border: Border.all(color: Colors.transparent),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      CatalogIcons.fromName(product.iconKey).icon,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.medium),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: text.labelMd),
                  Text(
                    l10n.productCatalogProductUnit(
                      CatalogUnits.resolveLabels(
                        context: context,
                        unit: CatalogUnits.fromName(product.unit),
                      ).short,
                    ),
                    style: text.bodyXs,
                  ),
                ],
              ),
              const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Skeleton.shade(
                      child: Icon(LucideIcons.chevronRight, size: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
