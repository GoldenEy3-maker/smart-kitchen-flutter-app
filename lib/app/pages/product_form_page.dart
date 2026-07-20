import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/app/router/app_router.dart";
import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_sizes.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_styles.dart";
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
    final appBarTitle = product != null ? product!.name : l10n.newProduct;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle),
        leadingWidth: ButtonSizes.iconSmall.minWidth,
        leading: Button(
          style: ButtonStyles.secondary,
          size: ButtonSizes.iconSmall,
          onPressed: () => router.maybePop(),
          child: const Icon(LucideIcons.chevronLeft, size: 22),
        ),
      ),
      body: ProductFormView(product: product),
    );
  }
}
