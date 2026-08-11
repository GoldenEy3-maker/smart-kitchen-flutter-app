import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/units/units.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/form_item/form_item.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";
import "package:smart_kitchen_flutter_app/core/widgets/toast/app_toast.dart";
import "package:smart_kitchen_flutter_app/features/product_form/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/products/navigation/navigation.dart";
import "package:smart_kitchen_flutter_app/domains/products/params/params.dart";
import "package:smart_kitchen_flutter_app/features/product_form/presentation/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/product_form/presentation/widgets/widgets.dart";
import "package:smart_kitchen_flutter_app/domains/categories/presentation/widgets/widgets.dart";

class ProductFormView extends StatefulWidget {
  const ProductFormView({
    super.key,
    this.product,
    required this.onGoBackRequested,
  });

  final Product? product;
  final void Function(OpenProductFormResultEvent event) onGoBackRequested;

  @override
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final _formKey = GlobalKey<FormState>();

  late final _nameController = TextEditingController(
    text: widget.product?.name,
  );
  final _iconErrorText = ValueNotifier<String?>(null);
  final _nameErrorText = ValueNotifier<String?>(null);
  final _categoryErrorText = ValueNotifier<String?>(null);
  final _unitErrorText = ValueNotifier<String?>(null);

  void _onCatalogIconsPickerSheetOpened(
    BuildContext context,
    CatalogIcons? initialSelectedCatalogIcon,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ProductFormBloc>();
    showCatalogIconsPickerSheet(
      context: context,
      initialSelectedCatalogIcon: initialSelectedCatalogIcon,
    ).then((newCatalogIcon) {
      if (newCatalogIcon != null) {
        bloc.add(ProductFormCatalogIconSelected(catalogIcon: newCatalogIcon));
        _iconErrorText.value = null;
      } else if (bloc.state.selectedCatalogIcon == null) {
        _iconErrorText.value = l10n.iconIsRequired;
      }
    });
  }

  void _onCategoryManagerSheetOpened({
    required BuildContext context,
    required List<CategoryWithProductsCount> categories,
    required CategoryWithProductsCount? initialSelectedCategory,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ProductFormBloc>();

    showCategoryManagerSheet(
      context: context,
      bloc: bloc,
      initialSelectedCategory: initialSelectedCategory,
    ).then((category) {
      if (category != null) {
        bloc.add(ProductFormCategorySelected(category: category));
        _categoryErrorText.value = null;
      } else if (bloc.state.selectedCategory == null) {
        _categoryErrorText.value = l10n.categoryIsRequired;
      }
    });
  }

  void _onCategoryCreateSheetOpened(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ProductFormBloc>();

    showCategoryCreateSheet(
      context: context,
      onCreate: (label, iconKey) async {
        final done = bloc.stream.firstWhere(
          (state) => !state.isCreateCategoryPending,
        );
        bloc.add(
          ProductFormCategoryCreateRequested(label: label, iconKey: iconKey),
        );
        final state = await done;

        final isSuccess = state.error == null;

        if (!isSuccess && mounted) {
          AppToast.showError(context, state.error!.localizedMessage(l10n));
        }

        if (isSuccess && mounted) {
          _categoryErrorText.value = null;
        }

        return isSuccess;
      },
    );
  }

  void _onCatalogUnitsPickerSheetOpened(
    BuildContext context,
    CatalogUnits? initialSelectedCatalogUnit,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ProductFormBloc>();
    showCatalogUnitsPickerSheet(
      context: context,
      initialSelectedUnit: initialSelectedCatalogUnit,
    ).then((newCatalogUnit) {
      if (newCatalogUnit != null) {
        bloc.add(ProductFormCatalogUnitSelected(catalogUnit: newCatalogUnit));
        _unitErrorText.value = null;
      } else if (bloc.state.selectedCatalogUnit == null) {
        _unitErrorText.value = l10n.unitIsRequired;
      }
    });
  }

  void _onSavePressed(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ProductFormBloc>();

    _nameErrorText.value = _nameController.text.isEmpty
        ? l10n.nameIsRequired
        : null;
    _iconErrorText.value = bloc.state.selectedCatalogIcon == null
        ? l10n.iconIsRequired
        : null;
    _categoryErrorText.value = bloc.state.selectedCategory == null
        ? l10n.categoryIsRequired
        : null;
    _unitErrorText.value = bloc.state.selectedCatalogUnit == null
        ? l10n.unitIsRequired
        : null;

    final isValid = [
      _nameErrorText.value,
      _iconErrorText.value,
      _categoryErrorText.value,
      _unitErrorText.value,
    ].where((errorText) => errorText != null).isEmpty;

    if (isValid) {
      final done = bloc.stream.firstWhere(
        (state) => !state.isSaveProductPending,
      );
      final shouldUseUpdate = widget.product != null;
      final blocEvent = shouldUseUpdate
          ? ProductFormUpdateRequested(
              params: UpdateProductParams(
                id: widget.product!.id,
                name: _nameController.text,
                iconKey: bloc.state.selectedCatalogIcon!.name,
                categoryId: bloc.state.selectedCategory!.id,
                unit: bloc.state.selectedCatalogUnit!.name,
              ),
            )
          : ProductFormCreateRequested(
              params: CreateProductParams(
                name: _nameController.text,
                iconKey: bloc.state.selectedCatalogIcon!.name,
                categoryId: bloc.state.selectedCategory!.id,
                unit: bloc.state.selectedCatalogUnit!.name,
              ),
            );

      bloc.add(blocEvent);

      final state = await done;
      final isSuccess = state.error == null && state.savedProduct != null;

      if (!isSuccess && mounted) {
        AppToast.showError(context, state.error!.localizedMessage(l10n));
      }

      if (isSuccess && mounted) {
        final product = state.savedProduct!;
        widget.onGoBackRequested(
          shouldUseUpdate
              ? OpenProductFormResultEventUpdated(
                  categories: state.categories.toCategories(),
                  product: product,
                )
              : OpenProductFormResultEventCreated(
                  categories: state.categories.toCategories(),
                  product: product,
                ),
        );
      }
    }
  }

  void _onDeletePressed(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<ProductFormBloc>();

    showProductConfirmDeleteSheet(
      context: context,
      onConfirm: () async {
        final done = bloc.stream.firstWhere(
          (state) => !state.isDeleteCategoryPending,
        );
        bloc.add(
          ProductFormDeleteRequested(
            params: DeleteProductParams(id: widget.product!.id),
          ),
        );
        final state = await done;
        final isSuccess = state.error == null;

        if (!isSuccess && mounted) {
          AppToast.showError(context, state.error!.localizedMessage(l10n));
        }

        if (isSuccess && mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.onGoBackRequested(
              OpenProductFormResultEventDeleted(
                product: widget.product!,
                categories: bloc.state.categories.toCategories(),
              ),
            );
          });
        }

        return isSuccess;
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameErrorText.dispose();
    _categoryErrorText.dispose();
    _unitErrorText.dispose();
    _iconErrorText.dispose();
    super.dispose();
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
            onPressed: () => widget.onGoBackRequested(
              OpenProductFormResultEventReturned(
                categories: context
                    .read<ProductFormBloc>()
                    .state
                    .categories
                    .toCategories(),
              ),
            ),
            child: const Icon(LucideIcons.chevronLeft, size: 22),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: AppSpacing.large,
            left: AppSpacing.containerHorizontal,
            right: AppSpacing.containerHorizontal,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: AppSpacing.xLarge,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListenableBuilder(
                  listenable: Listenable.merge([
                    _nameErrorText,
                    _iconErrorText,
                  ]),
                  builder: (context, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: AppSpacing.small,
                          children: [
                            BlocSelector<
                              ProductFormBloc,
                              ProductFormState,
                              CatalogIcons?
                            >(
                              selector: (state) => state.selectedCatalogIcon,
                              builder: (context, selectedCatalogIcon) {
                                return Button(
                                  style: selectedCatalogIcon != null
                                      ? ButtonStyles.secondarySelected
                                      : _iconErrorText.value != null
                                      ? ButtonStyles.secondaryDanger
                                      : ButtonStyles.secondary,
                                  size: ButtonSizes.icon,
                                  rounder: ButtonRounders.rectangular.copyWith(
                                    borderRadius:
                                        AppInputDecoration().shape.borderRadius,
                                  ),
                                  child: selectedCatalogIcon != null
                                      ? Icon(selectedCatalogIcon.icon, size: 20)
                                      : Icon(LucideIcons.tag, size: 20),
                                  onPressed: () {
                                    _onCatalogIconsPickerSheetOpened(
                                      context,
                                      selectedCatalogIcon,
                                    );
                                  },
                                );
                              },
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _nameController,
                                onChanged: (value) {
                                  _nameErrorText.value = value.isEmpty
                                      ? l10n.nameIsRequired
                                      : null;
                                },
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: AppInputDecoration(
                                  hintText: l10n.name,
                                  invalid: _nameErrorText.value != null,
                                ).toInputDecoration(),
                              ),
                            ),
                          ],
                        ),
                        if (_nameErrorText.value != null ||
                            _iconErrorText.value != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppSpacing.xSmall,
                            ),
                            child: Text(
                              [_iconErrorText.value, _nameErrorText.value]
                                  .where((errorText) => errorText != null)
                                  .join(", "),
                              style: AppTypography.textTheme.labelSmall!
                                  .copyWith(color: AppColors.dangerText),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: _categoryErrorText,
                  builder: (context, categoryErrorText, child) {
                    return FormItem(
                      label: Text(l10n.category),
                      errorMessage: categoryErrorText != null
                          ? Text(categoryErrorText)
                          : null,
                      child: Column(
                        spacing: AppSpacing.small,
                        children: [
                          BlocSelector<
                            ProductFormBloc,
                            ProductFormState,
                            ({
                              CategoryWithProductsCount? selectedCategory,
                              List<CategoryWithProductsCount> categories,
                              bool isCategoriesLoading,
                            })
                          >(
                            selector: (state) => (
                              selectedCategory: state.selectedCategory,
                              categories: state.categories,
                              isCategoriesLoading: state.isCategoriesLoading,
                            ),
                            builder: (context, slice) {
                              if (slice.isCategoriesLoading ||
                                  slice.categories.isNotEmpty) {
                                return SelectedCategoryCard(
                                  category: slice.selectedCategory,
                                  isLoading: slice.isCategoriesLoading,
                                  invalid: categoryErrorText != null,
                                  onPressed: () {
                                    _onCategoryManagerSheetOpened(
                                      context: context,
                                      categories: slice.categories,
                                      initialSelectedCategory:
                                          slice.selectedCategory,
                                    );
                                  },
                                );
                              }
                              return SizedBox.shrink();
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Button(
                              style: ButtonStyles.ghost,
                              size: ButtonSizes.sm,
                              rounder: ButtonRounders.rectangular,
                              onPressed: () =>
                                  _onCategoryCreateSheetOpened(context),
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
                    );
                  },
                ),
                Text(
                  l10n.productFormAttention,
                  style: AppTypography.textTheme.bodySmall!.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _unitErrorText,
                  builder: (context, unitErrorText, child) {
                    return FormItem(
                      label: Text(l10n.unitLabel),
                      errorMessage: unitErrorText != null
                          ? Text(unitErrorText)
                          : null,
                      child:
                          BlocSelector<
                            ProductFormBloc,
                            ProductFormState,
                            CatalogUnits?
                          >(
                            selector: (state) => state.selectedCatalogUnit,
                            builder: (context, selectedCatalogUnit) {
                              return InputButton(
                                invalid: unitErrorText != null,
                                onPressed: () =>
                                    _onCatalogUnitsPickerSheetOpened(
                                      context,
                                      selectedCatalogUnit,
                                    ),
                                hintText: l10n.selectUnit,
                                value: selectedCatalogUnit != null
                                    ? CatalogUnits.resolveLabels(
                                        context: context,
                                        unit: selectedCatalogUnit,
                                      ).full
                                    : null,
                              );
                            },
                          ),
                    );
                  },
                ),
                Column(
                  spacing: AppSpacing.small,
                  children: [
                    BlocSelector<ProductFormBloc, ProductFormState, bool>(
                      selector: (state) {
                        return state.isSaveProductPending;
                      },
                      builder: (context, isSaveProductPending) {
                        return SizedBox(
                          width: double.infinity,
                          child: Button(
                            disabled: isSaveProductPending,
                            onPressed: () => _onSavePressed(context),
                            style: ButtonStyles.primary.copyWith(
                              elevation: 6,
                              shadowColor: AppColors.primary.withValues(
                                alpha: 0.25,
                              ),
                            ),
                            child: Text(l10n.save, textAlign: .center),
                          ),
                        );
                      },
                    ),
                    if (widget.product != null)
                      SizedBox(
                        width: double.infinity,
                        child: Button(
                          onPressed: () => _onDeletePressed(context),
                          style: ButtonStyles.destructiveGhost,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: AppSpacing.small,
                            children: [
                              Icon(LucideIcons.trash2, size: 20),
                              Text(l10n.delete, textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
