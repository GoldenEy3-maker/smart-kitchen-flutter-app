import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/form_item/form_item.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/form/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/form/widgets/widgets.dart";
import "package:smart_kitchen_flutter_app/shared/categories/presentation/widgets/widgets.dart";

class ProductFormView extends StatefulWidget {
  const ProductFormView({
    super.key,
    this.product,
    required this.onGoBackPressed,
  });

  final Product? product;
  final VoidCallback onGoBackPressed;

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

    final appBarTitle = widget.product != null
        ? l10n.editProduct
        : l10n.newProduct;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle),
        leadingWidth:
            ButtonSizes.iconSmall.minWidth + AppSpacing.containerHorizontal,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.containerHorizontal),
          child: Button(
            style: ButtonStyles.secondary,
            size: ButtonSizes.iconSmall,
            rounder: ButtonRounders.circle,
            onPressed: widget.onGoBackPressed,
            child: const Icon(LucideIcons.chevronLeft, size: 22),
          ),
        ),
      ),
      body: BlocBuilder<ProductFormBloc, ProductFormState>(
        builder: (context, state) {
          return SafeArea(
            minimum: EdgeInsets.symmetric(
              horizontal: AppSpacing.containerHorizontal,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: AppSpacing.xLarge,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  FormItem(
                    label: Text(l10n.category),
                    child: Column(
                      spacing: AppSpacing.small,
                      children: [
                        SelectedCategoryCard(
                          category: state.selectedCategory,
                          onPressed: () {
                            showCategoryPickerSheet(
                              context: context,
                              categories: state.categories,
                            );
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Button(
                            style: ButtonStyles.ghost,
                            size: ButtonSizes.sm,
                            rounder: ButtonRounders.rectangular,
                            onPressed: () {
                              final bloc = context.read<ProductFormBloc>();

                              showCategoryCreateSheet(
                                context: context,
                                onCreate: (label, iconKey) async {
                                  final done = bloc.stream.firstWhere(
                                    (state) => !state.isCreateCategoryPending,
                                  );
                                  bloc.add(
                                    ProductFormCategoryCreateRequested(
                                      label: label,
                                      iconKey: iconKey,
                                    ),
                                  );
                                  final state = await done;
                                  // TODO: add error handling
                                  return state.error == null;
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: AppSpacing.small,
                              children: [
                                Icon(LucideIcons.plus, size: 20),
                                Text(l10n.createCategory),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    l10n.productFormAttention,
                    style: AppTypography.textTheme.bodySmall!.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
