import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:smart_kitchen_flutter_app/app/router/app_router.dart";
import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/form/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/form/views/views.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/usecases/usecases.dart";

@RoutePage()
class ProductFormPage extends StatelessWidget {
  const ProductFormPage({super.key, this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    final router = getIt.get<AppRouter>();

    return BlocProvider(
      create: (_) => ProductFormBloc(
        product: product,
        getCategoriesWithProductsCount: getIt
            .get<GetCategoriesWithProductsCount>(),
        createCategory: getIt.get<CreateCategory>(),
        deleteCategory: getIt.get<DeleteCategory>(),
        updateCategory: getIt.get<UpdateCategory>(),
        createProduct: getIt.get<CreateProduct>(),
        updateProduct: getIt.get<UpdateProduct>(),
        deleteProduct: getIt.get<DeleteProduct>(),
      )..add(ProductFormCategoriesRequested(product: product)),
      child: Scaffold(
        body: ProductFormView(
          product: product,
          onGoBackRequested: (event) => router.maybePop(event),
        ),
      ),
    );
  }
}
