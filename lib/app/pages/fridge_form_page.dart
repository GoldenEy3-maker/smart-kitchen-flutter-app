import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:smart_kitchen_flutter_app/app/router/app_router.dart";
import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/domains/products/navigation/navigation.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/presentation/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/presentation/views/views.dart";

@RoutePage()
class FridgeFormPage extends StatelessWidget {
  const FridgeFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt.get<AppRouter>();

    return BlocProvider(
      create: (_) => FridgeFormBloc(
        getProductsWithCategories: getIt.get<GetProductsWithCategories>(),
      )..add(const FridgeFormProductsRequested()),
      child: FridgeFormView(
        onGoBackRequested: router.maybePop,
        productsNavigator: getIt.get<ProductsNavigator>(),
      ),
    );
  }
}
