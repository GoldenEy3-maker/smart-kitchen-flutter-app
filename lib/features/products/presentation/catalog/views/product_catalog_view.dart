import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:skeletonizer/skeletonizer.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/empty_placeholder/empty_placeholder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/error_placeholder/error_placeholder.dart";
import "package:smart_kitchen_flutter_app/features/products/navigation/navigation.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/scroll/scroll.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/catalog/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/catalog/widgets/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:smart_kitchen_flutter_app/shared/categories/presentation/widgets/widgets.dart";

class ProductCatalogViewConfig {
  static const double verticalGap = AppSpacing.standard;

  static double categoryChipsHeight =
      CategoryChipsHeaderDelegate.kHeight + verticalGap * 2;
  static double searchBarHeight = SearchHeaderDelegate.kHeight;
  static double safeFooterHeight =
      AppSpacing.large * 2 + ButtonSizes.primary.minHeight;
}

class ProductCatalogView extends StatelessWidget {
  const ProductCatalogView({super.key, required this.navigator});

  final ProductsNavigator navigator;

  void _onProductFormOpened(BuildContext context, Product? product) async {
    final bloc = context.read<ProductCatalogBloc>();
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
          break;
        case OpenProductFormResultEventCreated():
          bloc.add(
            ProductCreated(
              product: event.product,
              categories: event.categories,
            ),
          );
          break;
        case OpenProductFormResultEventUpdated():
          bloc.add(
            ProductUpdated(
              product: event.product,
              categories: event.categories,
            ),
          );
          break;
        case OpenProductFormResultEventReturned():
          bloc.add(ProductCategoriesUpdated(categories: event.categories));
      }
    }
  }

  Future<void> _onRefreshRequested(BuildContext context) async {
    final bloc = context.read<ProductCatalogBloc>();
    final done = bloc.stream.firstWhere((state) => !state.isLoading);
    bloc.add(const LoadProductCatalogRequested());
    await done;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCatalogBloc, ProductCatalogState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final categoryProducts = state.isLoading
            ? [
                CategoryProduct.loading,
                CategoryProduct.loading,
                CategoryProduct.loading,
              ]
            : state.filteredCategoryProducts;
        final isEmpty = state.filteredCategoryProducts.isEmpty;
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
                        color: AppColors.textSecondary,
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

        return ProductCatalogScaffold(
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
                            .read<ProductCatalogBloc>()
                            .add(SearchQueryChanged(query: value)),
                        height: ProductCatalogViewConfig.searchBarHeight,
                        paddingHorizontal: AppSpacing.containerHorizontal,
                      ),
                    ),
                  if (shouldShowFilters)
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: CategoryChipsHeaderDelegate(
                        height: ProductCatalogViewConfig.categoryChipsHeight,
                        paddingVertical: ProductCatalogViewConfig.verticalGap,
                        paddingHorizontal: AppSpacing.containerHorizontal,
                        isLoading: state.isLoading,
                        categories: state.categoryProducts.toCategories(),
                        selectedCategory: state.selectedCategory,
                        onCategorySelected: (category) => context
                            .read<ProductCatalogBloc>()
                            .add(SelectedCategoryChanged(category: category)),
                      ),
                    ),
                  if (!isEmpty || state.isLoading) ...[
                    for (var i = 0; i < categoryProducts.length; i++) ...[
                      if (i > 0)
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: ProductCatalogViewConfig.verticalGap,
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
                              categoryProducts[i].category.label.toUpperCase(),
                              style: AppTypography.textTheme.titleSmall,
                            ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: ProductCatalogViewConfig.verticalGap,
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.containerHorizontal,
                        ),
                        sliver: SliverList.separated(
                          itemCount: categoryProducts[i].products.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: ProductCatalogViewConfig.verticalGap,
                            );
                          },
                          itemBuilder: (context, index) {
                            final product = categoryProducts[i].products[index];
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
                        height: ProductCatalogViewConfig.safeFooterHeight,
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
