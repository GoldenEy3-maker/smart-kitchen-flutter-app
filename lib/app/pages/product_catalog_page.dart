import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/presentation/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/presentation/views/product_catalog_view.dart";

@RoutePage()
class ProductCatalogPage extends StatelessWidget {
  const ProductCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n.productCatalogTitle))),
      body: BlocProvider(
        create: (context) => ProductCatalogBloc(
          getCategories: getIt.get<GetCategories>(),
          getProducts: getIt.get<GetProducts>(),
        )..add(LoadProductCatalogRequested()),
        child: ProductCatalogView(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {},
        icon: Icon(LucideIcons.plus, size: 20),
        label: Text("Add Product"),
      ),
    );
  }
}
