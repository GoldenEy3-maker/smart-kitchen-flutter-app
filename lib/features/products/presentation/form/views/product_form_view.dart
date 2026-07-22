import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
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
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final _formKey = GlobalKey<FormState>();
  late CatalogIcon? _selectedIconKey = widget.product?.iconKey != null
      ? CatalogIcon.fromName(widget.product!.iconKey)
      : null;

  void _onSelectedIconKey(CatalogIcon? iconKey) {
    setState(() {
      _selectedIconKey = iconKey;
    });
  }

  void _onCatalogIconsPickerSheetOpened(BuildContext context) {
    showCatalogIconsPickerSheet(
      context: context,
      initialSelectedIconKey: _selectedIconKey,
    ).then((newIconKey) {
      if (newIconKey != null) {
        _onSelectedIconKey(newIconKey);
      }
    });
  }

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
                  child: _selectedIconKey != null
                      ? Icon(_selectedIconKey!.icon, size: 20)
                      : Icon(LucideIcons.tag, size: 20),
                  onPressed: () {
                    _onCatalogIconsPickerSheetOpened(context);
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
