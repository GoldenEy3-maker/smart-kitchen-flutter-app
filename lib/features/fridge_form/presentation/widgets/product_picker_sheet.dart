import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/empty_placeholder/empty_placeholder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/scroll_sheet_to_item.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/presentation/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/fridge_form/presentation/widgets/widgets.dart";

const _maxSheetSize = 0.9;
const _initialSheetSize = 0.53;

Future<ProductWithCategory?> showProductPickerSheet({
  required BuildContext context,
  required FridgeFormBloc bloc,
  ProductWithCategory? initialSelectedProduct,
}) {
  return showResizableSheet(
    context: context,
    initialSize: _initialSheetSize,
    maxSize: _maxSheetSize,
    fitMaxSizeToContent: true,
    builder: (context, scrollController, sheetController) => BlocProvider.value(
      value: bloc,
      child: ProductPickerSheetView(
        scrollController: scrollController,
        sheetController: sheetController,
        initialSelectedProduct: initialSelectedProduct,
      ),
    ),
  );
}

class ProductPickerSheetView extends StatefulWidget {
  const ProductPickerSheetView({
    required this.scrollController,
    required this.sheetController,
    this.initialSelectedProduct,
    super.key,
  });

  final ScrollController scrollController;
  final DraggableScrollableController sheetController;
  final ProductWithCategory? initialSelectedProduct;

  @override
  State<ProductPickerSheetView> createState() => _ProductPickerSheetViewState();
}

class _ProductPickerSheetViewState extends State<ProductPickerSheetView> {
  late final ValueNotifier<ProductWithCategory?> _selectedProduct =
      ValueNotifier(widget.initialSelectedProduct);
  final ValueNotifier<String> _searchQuery = ValueNotifier("");
  final _searchController = TextEditingController();

  List<ProductWithCategory> _filteredProducts(
    List<ProductWithCategory> products,
  ) {
    final query = _searchQuery.value.toLowerCase().trim();
    if (query.isEmpty) {
      return products;
    }

    return products
        .where((product) => product.product.name.toLowerCase().contains(query))
        .toList();
  }

  void _onSelectPressed() {
    Navigator.pop(context, _selectedProduct.value);
  }

  void _scrollToInitialSelectedProduct() {
    final bloc = context.read<FridgeFormBloc>();
    final initialSelectedProduct = widget.initialSelectedProduct;
    if (initialSelectedProduct == null) {
      return;
    }

    unawaited(
      scrollSheetToItem(
        scrollController: widget.scrollController,
        sheetController: widget.sheetController,
        index: bloc.state.products.indexWhere(
          (product) => product.product.id == initialSelectedProduct.product.id,
        ),
        itemExtent: ProductPickerTile.height,
        maxSheetSize: _maxSheetSize,
      ),
    );
  }

  Widget _emptyPlaceholder({required bool isSearchApplied}) {
    final l10n = context.l10n;
    final colors = context.theme.colors;

    return EmptyPlaceholder(
      icon: isSearchApplied
          ? Icon(LucideIcons.searchX, size: 40, color: colors.textSecondary)
          : null,
      title: isSearchApplied
          ? l10n.emptyPlaceholderSearchTitle
          : l10n.emptyPlaceholderProductTitle,
      description: isSearchApplied
          ? l10n.emptyPlaceholderSearchProductsDescription
          : l10n.emptyPlaceholderProductDescription,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialSelectedProduct();
    });
  }

  @override
  void dispose() {
    _selectedProduct.dispose();
    _searchQuery.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final text = context.theme.text;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.containerHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: colors.surface,
            padding: const EdgeInsets.only(
              top: AppSpacing.xLarge,
              bottom: AppSpacing.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.medium,
              children: [
                Text(l10n.selectProduct, style: text.headingLg),
                TextField(
                  controller: _searchController,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) => _searchQuery.value = value,
                  decoration: AppInputDecoration(
                    context: context,
                    hintText: l10n.findInCatalogHint,
                    prefixIcon: const Icon(LucideIcons.search, size: 20),
                    shape: AppInputShapes.circular,
                  ).toInputDecoration(),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                ValueListenableBuilder(
                  valueListenable: _searchQuery,
                  builder: (context, searchQuery, child) {
                    return ValueListenableBuilder(
                      valueListenable: _selectedProduct,
                      builder: (context, selectedProduct, child) {
                        return BlocSelector<
                          FridgeFormBloc,
                          FridgeFormState,
                          List<ProductWithCategory>
                        >(
                          selector: (state) => state.products,
                          builder: (context, products) {
                            final filteredProducts = _filteredProducts(
                              products,
                            );

                            if (filteredProducts.isEmpty) {
                              return SliverFillRemaining(
                                hasScrollBody: false,
                                child: Center(
                                  child: _emptyPlaceholder(
                                    isSearchApplied: searchQuery
                                        .trim()
                                        .isNotEmpty,
                                  ),
                                ),
                              );
                            }

                            return SliverList.builder(
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = filteredProducts[index];
                                final isSelected =
                                    selectedProduct?.product.id ==
                                    product.product.id;

                                return ProductPickerTile(
                                  key: ValueKey(product.product.id),
                                  selected: isSelected,
                                  product: product,
                                  onPressed: () {
                                    _selectedProduct.value = product;
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: colors.surface,
            padding: const EdgeInsets.only(top: AppSpacing.medium),
            child: Button(
              onPressed: _onSelectPressed,
              child: Text(l10n.select, textAlign: .center),
            ),
          ),
        ],
      ),
    );
  }
}
