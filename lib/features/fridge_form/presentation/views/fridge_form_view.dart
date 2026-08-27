import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/form_item/form_item.dart";
import "package:smart_kitchen_flutter_app/domains/products/navigation/navigation.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/presentation/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/presentation/widgets/widgets.dart";

class FridgeFormView extends StatefulWidget {
  const FridgeFormView({
    required this.onGoBackRequested,
    required this.productsNavigator,
    super.key,
  });

  final void Function() onGoBackRequested;
  final ProductsNavigator productsNavigator;

  @override
  State<FridgeFormView> createState() => _FridgeFormViewState();
}

class _FridgeFormViewState extends State<FridgeFormView> {
  final _productErrorText = ValueNotifier<String?>(null);

  Future<void> _onProductPickerSheetOpened({
    required BuildContext context,
    required ProductWithCategory? initialSelectedProduct,
  }) async {
    final l10n = context.l10n;
    final bloc = context.read<FridgeFormBloc>();

    final newProduct = await showProductPickerSheet(
      context: context,
      bloc: bloc,
      initialSelectedProduct: initialSelectedProduct,
    );

    if (newProduct != null) {
      bloc.add(FridgeFormProductSelected(product: newProduct));
      _productErrorText.value = null;
    } else if (bloc.state.selectedProduct == null) {
      _productErrorText.value = l10n.productIsRequired;
    }
  }

  @override
  void dispose() {
    _productErrorText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = context.theme.text;
    final colors = context.theme.colors;
    final buttonStyles = ButtonStyles.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fridgeFormPageAppBarTitle),
        centerTitle: true,
        leadingWidth:
            ButtonSizes.iconSmall.minWidth + AppSpacing.containerHorizontal,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.containerHorizontal),
          child: Button(
            style: buttonStyles.secondary,
            size: ButtonSizes.iconSmall,
            rounder: ButtonRounders.circle,
            onPressed: () => widget.onGoBackRequested(),
            child: const Icon(LucideIcons.chevronLeft, size: 22),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: AppSpacing.medium,
            bottom: AppSpacing.standard,
            left: AppSpacing.containerHorizontal,
            right: AppSpacing.containerHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.fridgeFormStepFirst,
                style: text.bodyXs.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.standard),
              ValueListenableBuilder(
                valueListenable: _productErrorText,
                builder: (context, productErrorText, child) {
                  return FormItem(
                    errorMessage: productErrorText != null
                        ? Text(productErrorText)
                        : null,
                    child: Column(
                      children: [
                        BlocSelector<
                          FridgeFormBloc,
                          FridgeFormState,
                          ({
                            List<ProductWithCategory> products,
                            ProductWithCategory? selectedProduct,
                            bool isProductsLoading,
                          })
                        >(
                          selector: (state) => (
                            products: state.products,
                            selectedProduct: state.selectedProduct,
                            isProductsLoading: state.isProductsLoading,
                          ),
                          builder: (context, slice) {
                            if (slice.isProductsLoading ||
                                slice.products.isNotEmpty) {
                              return Column(
                                children: [
                                  SelectedProductCard(
                                    product: slice.selectedProduct,
                                    isLoading: slice.isProductsLoading,
                                    invalid: productErrorText != null,
                                    onPressed: () {
                                      unawaited(
                                        _onProductPickerSheetOpened(
                                          context: context,
                                          initialSelectedProduct:
                                              slice.selectedProduct,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: AppSpacing.small),
                                ],
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                        Button(
                          onPressed: () {
                            widget.productsNavigator.openProductForm();
                          },
                          style: buttonStyles.ghost,
                          size: ButtonSizes.sm,
                          child: Row(
                            spacing: AppSpacing.small,
                            children: [
                              const Icon(LucideIcons.plus, size: 20),
                              Text(l10n.createNewProductInCatalog),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
