import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/emoji_text/emoji_text.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/entities/entities.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.small)),
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            color: AppColors.surface,
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.small)),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.medium),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.iconBg,
                    border: Border.all(color: Colors.transparent),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: EmojiText(
                      emoji: product.emoji,
                      style: theme.textTheme.labelLarge,
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
                    children: [Icon(LucideIcons.chevronRight, size: 18)],
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
