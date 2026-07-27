import "package:flutter/material.dart";
import "package:skeletonizer/skeletonizer.dart";
import "package:smart_kitchen_flutter_app/core/icons/catalog_icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/features/products/navigation/navigation.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";

class ProductTile extends StatelessWidget {
  final Product product;
  final ProductsNavigator navigator;

  const ProductTile({
    super.key,
    required this.product,
    required this.navigator,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Material(
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.small)),
        side: Border.all(color: AppColors.border).top,
      ),
      child: InkWell(
        onTap: () => navigator.openProductForm(product: product),
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.small)),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.small)),
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
                    color: AppColors.iconBg,
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
                  Text(product.name, style: theme.textTheme.titleMedium),
                  Text(
                    l10n.productCatalogProductUnit(product.unit),
                    style: theme.textTheme.bodySmall,
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
