import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/features/products/navigation/navigation.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/catalog/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/catalog/views/views.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/usecases/usecases.dart";

@RoutePage()
class ProductCatalogPage extends StatelessWidget {
  const ProductCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCatalogBloc(
        getCategories: getIt.get<GetCategories>(),
        getProducts: getIt.get<GetProducts>(),
      )..add(LoadProductCatalogRequested()),
      child: ProductCatalogView(navigator: getIt.get<ProductsNavigator>()),
    );
  }
}
