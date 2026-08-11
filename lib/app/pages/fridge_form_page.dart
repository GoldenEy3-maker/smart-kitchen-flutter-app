import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/presentation/views/views.dart";

@RoutePage()
class FridgeFormPage extends StatelessWidget {
  const FridgeFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FridgeFormView();
  }
}
