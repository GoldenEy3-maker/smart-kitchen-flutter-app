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

  void _onCatalogIconsPickerSheetOpened(
    BuildContext context,
    CatalogIcons? initialSelectedCatalogIcon,
  ) {
    showCatalogIconsPickerSheet(
      context: context,
      initialSelectedCatalogIcon: initialSelectedCatalogIcon,
    ).then((newCatalogIcon) {
      if (newCatalogIcon != null) {
        context.read<ProductFormBloc>().add(
          ProductFormCatalogIconSelected(catalogIcon: newCatalogIcon),
        );
      }
    });
  }

  void _onCategoryManagerSheetOpened({
    required BuildContext context,
    required List<CategoryWithProductsCount> categories,
    required CategoryWithProductsCount? initialSelectedCategory,
  }) {
    final bloc = context.read<ProductFormBloc>();

    showCategoryManagerSheet(
      context: context,
      bloc: bloc,
      initialSelectedCategory: initialSelectedCategory,
    ).then((category) {
      if (category == null) return;
      context.read<ProductFormBloc>().add(
        ProductFormCategorySelected(category: category),
      );
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

        return isSuccess;
      },
    );
  }

  void _onCatalogUnitsPickerSheetOpened(
    BuildContext context,
    CatalogUnits? initialSelectedCatalogUnit,
  ) {
    showCatalogUnitsPickerSheet(
      context: context,
      initialSelectedUnit: initialSelectedCatalogUnit,
    ).then((newCatalogUnit) {
      if (newCatalogUnit != null) {
        context.read<ProductFormBloc>().add(
          ProductFormCatalogUnitSelected(catalogUnit: newCatalogUnit),
        );
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
      body: SafeArea(
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
                            : ButtonStyles.secondary,
                        size: ButtonSizes.icon,
                        rounder: ButtonRounders.rectangular.copyWith(
                          borderRadius: AppInputDecoration().shape.borderRadius,
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
                            onPressed: () {
                              _onCategoryManagerSheetOpened(
                                context: context,
                                categories: slice.categories,
                                initialSelectedCategory: slice.selectedCategory,
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
                        onPressed: () => _onCategoryCreateSheetOpened(context),
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
              FormItem(
                label: Text(l10n.unitLabel),
                child:
                    BlocSelector<
                      ProductFormBloc,
                      ProductFormState,
                      CatalogUnits?
                    >(
                      selector: (state) => state.selectedCatalogUnit,
                      builder: (context, selectedCatalogUnit) {
                        return InputButton(
                          onPressed: () => _onCatalogUnitsPickerSheetOpened(
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
              ),
              SizedBox(
                width: double.infinity,
                child: Button(
                  onPressed: () {
                    // TODO: implement save
                  },
                  style: ButtonStyles.primary.copyWith(
                    elevation: 6,
                    shadowColor: AppColors.primary.withValues(alpha: 0.25),
                  ),
                  child: Text(l10n.save, textAlign: .center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
