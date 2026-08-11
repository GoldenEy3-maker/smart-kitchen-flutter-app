import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";

class FridgeFormView extends StatelessWidget {
  const FridgeFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.fridgeFormPageAppBarTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [Text("Fridge Form")]),
        ),
      ),
    );
  }
}
