import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/features/recipes_catalog/presentation/views/views.dart";

@RoutePage()
class RecipesCatalogPage extends StatelessWidget {
  const RecipesCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecipesCatalogView();
  }
}
