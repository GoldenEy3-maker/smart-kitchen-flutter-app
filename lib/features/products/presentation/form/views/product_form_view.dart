import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/utils/show_platform_sheet.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
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
      minimum: EdgeInsets.symmetric(horizontal: AppSpacing.containerHorizontal),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              spacing: AppSpacing.small,
              children: [
                Button(
                  style: ButtonStyles.secondary,
                  size: ButtonSizes.icon,
                  rounder: ButtonRounders.rectangular.copyWith(
                    borderRadius: AppInputDecoration().shape.borderRadius,
                  ),
                  child: widget.product != null
                      ? Icon(CatalogIcons.resolveByKey(widget.product!.iconKey))
                      : Icon(LucideIcons.tag, size: 20),
                  onPressed: () {
                    showPlatformSheet(
                      context: context,
                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisSize: .min,
                            children: [Text("Hello")],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: widget.product?.name,
                    decoration: AppInputDecoration(
                      hintText: l10n.name,
                    ).toInputDecoration(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
