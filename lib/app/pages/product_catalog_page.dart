import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_styles.dart";
import "package:smart_kitchen_flutter_app/features/products/navigation/navigation.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/catalog/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/catalog/views/views.dart";

@RoutePage()
class ProductCatalogPage extends StatelessWidget {
  const ProductCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(l10n.productCatalogTitle)),
      body: BlocProvider(
        create: (context) => ProductCatalogBloc(
          getCategories: getIt.get<GetCategories>(),
          getProducts: getIt.get<GetProducts>(),
        )..add(LoadProductCatalogRequested()),
        child: ProductCatalogView(navigator: getIt.get<ProductsNavigator>()),
      ),
      floatingActionButton: Button(
        style: ButtonStyles.primary.copyWith(
          elevation: 6,
          shadowColor: AppColors.primary.withValues(alpha: 0.35),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.small,
          children: [Icon(LucideIcons.plus, size: 20), Text(l10n.newProduct)],
        ),
        onPressed: () => getIt.get<ProductsNavigator>().openProductForm(),
      ),
    );
  }
}
