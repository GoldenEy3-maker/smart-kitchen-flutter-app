import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/navigation/navigation.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/domain/usecases/usecases.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/presentation/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/presentation/views/views.dart";

@RoutePage()
class FridgeCatalogPage extends StatelessWidget {
  const FridgeCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FridgeCatalogBloc(
        getCategories: getIt.get<GetCategories>(),
        getFridgeCatalogItems: getIt.get<GetFridgeCatalogItems>(),
      )..add(const LoadFridgeCatalogRequested()),
      child: FridgeCatalogView(fridgeNavigator: getIt.get<FridgeNavigator>()),
    );
  }
}
