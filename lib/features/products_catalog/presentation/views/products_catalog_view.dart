import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:skeletonizer/skeletonizer.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/empty_placeholder/empty_placeholder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/error_placeholder/error_placeholder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/scroll/scroll.dart";
import "package:smart_kitchen_flutter_app/domains/categories/presentation/widgets/widgets.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/products/navigation/navigation.dart";
import "package:smart_kitchen_flutter_app/features/products_catalog/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products_catalog/presentation/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/products_catalog/presentation/widgets/widgets.dart";

final class _ProductsCatalogViewConfig {
  _ProductsCatalogViewConfig._();

  static const double verticalGap = AppSpacing.standard;

  static const double categoryChipsHeight =
      CategoryChipsHeaderDelegate.kHeight + verticalGap * 2;
  static final double searchBarHeight = SearchHeaderDelegate.kHeight;
  static final double safeFooterHeight =
      AppSpacing.standard * 2 + ButtonSizes.primary.minHeight;
  static const double productListVerticalGap = verticalGap - 6;
}

class ProductsCatalogView extends StatelessWidget {
  const ProductsCatalogView({required this.navigator, super.key});

  final ProductsNavigator navigator;

  Future<void> _onProductFormOpened(
    BuildContext context,
    Product? product,
  ) async {
    final bloc = context.read<ProductsCatalogBloc>();
    final event = await navigator.openProductForm(product: product);
    if (event != null) {
      switch (event) {
        case OpenProductFormResultEventDeleted():
          bloc.add(
            ProductDeleted(
              product: event.product,
              categories: event.categories,
            ),
          );
        case OpenProductFormResultEventCreated():
          bloc.add(
            ProductCreated(
              product: event.product,
              categories: event.categories,
            ),
          );
        case OpenProductFormResultEventUpdated():
          bloc.add(
            ProductUpdated(
              product: event.product,
              categories: event.categories,
            ),
          );
        case OpenProductFormResultEventReturned():
          bloc.add(ProductCategoriesUpdated(categories: event.categories));
      }
    }
  }

  Future<void> _onRefreshRequested(BuildContext context) async {
    final bloc = context.read<ProductsCatalogBloc>();
    final done = bloc.stream.firstWhere((state) => !state.isLoading);
    bloc.add(const LoadProductsCatalogRequested());
    await done;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCatalogBloc, ProductsCatalogState>(
      builder: (context, state) {
        final l10n = context.l10n;
        final colors = context.theme.colors;
        final text = context.theme.text;

        final categoryWithProducts = state.isLoading
            ? [
                CategoryWithProducts.loading(),
                CategoryWithProducts.loading(),
                CategoryWithProducts.loading(),
              ]
            : state.filteredCategoryWithProducts;
        final isEmpty = state.filteredCategoryWithProducts.isEmpty;
        final isSearchQueryApplied = state.searchQuery.isNotEmpty;
        final shouldShowFilters =
            !isEmpty || state.isLoading || isSearchQueryApplied;
        final isError = state.error != null;

        final placeholder = isError
            ? ErrorPlaceholder(
                onTryAgain: () => _onRefreshRequested(context),
                errorMessage: state.error!.localizedMessage(l10n),
              )
            : EmptyPlaceholder(
                icon: isSearchQueryApplied
                    ? Icon(
                        LucideIcons.searchX,
                        size: 40,
                        color: colors.textSecondary,
                      )
                    : null,
                title: isSearchQueryApplied
                    ? l10n.emptyPlaceholderSearchTitle
                    : l10n.emptyPlaceholderProductTitle,
                description: isSearchQueryApplied
                    ? l10n.emptyPlaceholderSearchProductsDescription
                    : l10n.emptyPlaceholderProductDescription,
                action: Row(
                  mainAxisAlignment: .center,
                  children: [
                    CreateProductButton(
                      onPressed: () => _onProductFormOpened(context, null),
                    ),
                  ],
                ),
              );

        return ProductsCatalogScaffold(
          floatingActionButton: isEmpty
              ? null
              : CreateProductButton(
                  onPressed: () => _onProductFormOpened(context, null),
                ),
          body: RefreshIndicator(
            onRefresh: () => _onRefreshRequested(context),
            child: SafeArea(
              child: CustomScrollView(
                physics: const NoImplicitScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  if (shouldShowFilters)
                    SliverPersistentHeader(
                      floating: true,
                      delegate: SearchHeaderDelegate(
                        onChanged: (value) => context
                            .read<ProductsCatalogBloc>()
                            .add(SearchQueryChanged(query: value)),
                        height: _ProductsCatalogViewConfig.searchBarHeight,
                        paddingHorizontal: AppSpacing.containerHorizontal,
                        hintText: l10n.productCatalogSearchHint,
                      ),
                    ),
                  if (shouldShowFilters)
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: CategoryChipsHeaderDelegate(
                        height: _ProductsCatalogViewConfig.categoryChipsHeight,
                        paddingVertical: _ProductsCatalogViewConfig.verticalGap,
                        paddingHorizontal: AppSpacing.containerHorizontal,
                        isLoading: state.isLoading,
                        categories: state.categoryWithProducts.toCategories(),
                        selectedCategory: state.selectedCategory,
                        onCategorySelected: (category) => context
                            .read<ProductsCatalogBloc>()
                            .add(SelectedCategoryChanged(category: category)),
                      ),
                    ),
                  if (!isEmpty || state.isLoading) ...[
                    for (var i = 0; i < categoryWithProducts.length; i++) ...[
                      if (i > 0)
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: _ProductsCatalogViewConfig.verticalGap,
                          ),
                        ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.containerHorizontal,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Skeletonizer(
                            enabled: state.isLoading,
                            child: Text(
                              categoryWithProducts[i].category.label
                                  .toUpperCase(),
                              style: text.labelXs,
                            ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height:
                              _ProductsCatalogViewConfig.productListVerticalGap,
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.containerHorizontal,
                        ),
                        sliver: SliverList.separated(
                          itemCount: categoryWithProducts[i].products.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: _ProductsCatalogViewConfig
                                  .productListVerticalGap,
                            );
                          },
                          itemBuilder: (context, index) {
                            final product =
                                categoryWithProducts[i].products[index];
                            return Skeletonizer(
                              enabled: state.isLoading,
                              child: ProductTile(
                                onPressed: () =>
                                    _onProductFormOpened(context, product),
                                product: product,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: _ProductsCatalogViewConfig.safeFooterHeight,
                      ),
                    ),
                  ] else
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: .center,
                        children: [placeholder],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
