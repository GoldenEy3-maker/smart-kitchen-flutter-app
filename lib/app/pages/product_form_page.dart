import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/app/router/app_router.dart";
import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/form/views/views.dart";

@RoutePage()
class ProductFormPage extends StatelessWidget {
  final Product? product;

  const ProductFormPage({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final router = getIt.get<AppRouter>();
    final appBarTitle = product != null ? l10n.editProduct : l10n.newProduct;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle),
        leadingWidth:
            ButtonSizes.iconSmall.minWidth + AppSpacing.containerHorizontal,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.containerHorizontal),
          child: Button(
            style: ButtonStyles.secondary,
            size: ButtonSizes.iconSmall,
            rounder: ButtonRounders.circle,
            onPressed: () => router.maybePop(),
            child: const Icon(LucideIcons.chevronLeft, size: 22),
          ),
        ),
      ),
      body: ProductFormView(product: product),
    );
  }
}
