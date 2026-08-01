import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/presentation/views/views.dart";

@RoutePage()
class FridgeCatalogPage extends StatelessWidget {
  const FridgeCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FridgeCatalogView();
  }
}
