import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/presentation/views/product_catalog_view.dart";

@RoutePage()
class ProductCatalogPage extends StatelessWidget {
  const ProductCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n.productCatalogTitle))),
      body: ProductCatalogView(),
    );
  }
}
