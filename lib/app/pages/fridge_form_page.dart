import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/app/router/app_router.dart";
import "package:smart_kitchen_flutter_app/core/di/get_it.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/presentation/views/views.dart";

@RoutePage()
class FridgeFormPage extends StatelessWidget {
  const FridgeFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt.get<AppRouter>();

    return FridgeFormView(onGoBackRequested: router.maybePop);
  }
}
