import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";

class ProductCatalogScaffold extends StatelessWidget {
  const ProductCatalogScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
  });

  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(l10n.productCatalogTitle)),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
