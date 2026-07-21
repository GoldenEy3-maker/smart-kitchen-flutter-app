import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";

class ProductFormView extends StatefulWidget {
  final Product? product;

  const ProductFormView({super.key, this.product});

  @override
  ProductFormViewState createState() => ProductFormViewState();
}

class ProductFormViewState extends State<ProductFormView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: AppInputDecoration(
                hintText: l10n.enterName,
              ).toInputDecoration(),
            ),
          ],
        ),
      ),
    );
  }
}
