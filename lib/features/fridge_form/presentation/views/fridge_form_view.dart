import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";

class FridgeFormView extends StatelessWidget {
  const FridgeFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
