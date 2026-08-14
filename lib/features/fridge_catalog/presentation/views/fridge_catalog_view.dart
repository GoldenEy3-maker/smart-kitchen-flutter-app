import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:skeletonizer/skeletonizer.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/empty_placeholder/empty_placeholder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/error_placeholder/error_placeholder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/scroll/scroll.dart";
import "package:smart_kitchen_flutter_app/core/widgets/search_header_delegate/search_header_delegate.dart";
import "package:smart_kitchen_flutter_app/domains/categories/presentation/widgets/category_chips_header_delegate.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/presentation/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/fridge_catalog/presentation/widgets/widgets.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/navigation/navigation.dart";

final class _FridgeCatalogViewConfig {
  _FridgeCatalogViewConfig._();

  static const double verticalGap = AppSpacing.standard;
  static final double searchBarHeight = SearchHeaderDelegate.kHeight;
  static final double categoryChipsHeight =
      CategoryChipsHeaderDelegate.kHeight + verticalGap * 2;
  static final double safeFooterHeight =
      AppSpacing.large * 2 + ButtonSizes.primary.minHeight;
  static const double productListVerticalGap = verticalGap - 6;
}

class FridgeCatalogView extends StatelessWidget {
  const FridgeCatalogView({super.key, required this._fridgeNavigator});

  final FridgeNavigator _fridgeNavigator;

  void _onFridgeFormOpened() {
    _fridgeNavigator.openFridgeForm();
  }

  Future<void> _onRefreshRequested(BuildContext context) async {
    final bloc = context.read<FridgeCatalogBloc>();
    final done = bloc.stream.firstWhere((state) => !state.isLoading);
    bloc.add(const LoadFridgeCatalogRequested());
    await done;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final text = context.theme.text;

    return BlocBuilder<FridgeCatalogBloc, FridgeCatalogState>(
      builder: (context, state) {
        final categoryWithFridgeProducts = state.isLoading
            ? [
                CategoryWithFridgeProductItems.loading,
                CategoryWithFridgeProductItems.loading,
                CategoryWithFridgeProductItems.loading,
              ]
            : state.filteredCategoriesWithFridgeProducts;
        final isEmpty = state.filteredCategoriesWithFridgeProducts.isEmpty;
        final isSearchQueryApplied = state.searchQuery.isNotEmpty;
        final shouldShowFilters =
            !isEmpty || state.isLoading || isSearchQueryApplied;
        final isError = state.error != null;

        final placeholder = isError
            ? ErrorPlaceholder(
                errorMessage: state.error!.localizedMessage(l10n),
                onTryAgain: () => _onRefreshRequested(context),
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
                    : l10n.emptyPlaceholderFridgeProductsTitle,
                description: isSearchQueryApplied
                    ? l10n.emptyPlaceholderSearchProductsDescription
                    : l10n.emptyPlaceholderFridgeProductsDescription,
                action: Row(
                  mainAxisAlignment: .center,
                  children: [
                    AddFridgeProductButton(
                      onPressed: () => _onFridgeFormOpened(),
                    ),
                  ],
                ),
              );

        return Scaffold(
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
                            .read<FridgeCatalogBloc>()
                            .add(SearchQueryChanged(query: value)),
                        height: _FridgeCatalogViewConfig.searchBarHeight,
                        paddingHorizontal: AppSpacing.containerHorizontal,
                        hintText: l10n.findProductsHint,
                      ),
                    ),
                  if (shouldShowFilters)
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: CategoryChipsHeaderDelegate(
                        height: _FridgeCatalogViewConfig.categoryChipsHeight,
                        paddingVertical: _FridgeCatalogViewConfig.verticalGap,
                        paddingHorizontal: AppSpacing.containerHorizontal,
                        isLoading: state.isLoading,
                        categories: state.categoriesWithFridgeProducts
                            .toCategories(),
                        selectedCategory: state.selectedCategory,
                        onCategorySelected: (category) => context
                            .read<FridgeCatalogBloc>()
                            .add(SelectedCategoryChanged(category: category)),
                      ),
                    ),
                  if (!isEmpty || state.isLoading) ...[
                    for (
                      var i = 0;
                      i < categoryWithFridgeProducts.length;
                      i++
                    ) ...[
                      if (i > 0)
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: _FridgeCatalogViewConfig.verticalGap,
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
                              categoryWithFridgeProducts[i].category.label
                                  .toUpperCase(),
                              style: text.headingLg,
                            ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height:
                              _FridgeCatalogViewConfig.productListVerticalGap,
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.containerHorizontal,
                        ),
                        sliver: SliverList.separated(
                          itemCount: categoryWithFridgeProducts[i]
                              .fridgeProducts
                              .length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: _FridgeCatalogViewConfig
                                  .productListVerticalGap,
                            );
                          },
                          itemBuilder: (context, index) {
                            final fridgeProduct = categoryWithFridgeProducts[i]
                                .fridgeProducts[index];
                            return Skeletonizer(
                              enabled: state.isLoading,
                              // child: FridgeProductTile(
                              //   onPressed: () =>
                              //       _onFridgeFormOpened(),
                              //   fridgeProduct: fridgeProduct,
                              // ),
                              child: Text("FridgeProductTile"),
                            );
                          },
                        ),
                      ),
                    ],
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: _FridgeCatalogViewConfig.safeFooterHeight,
                      ),
                    ),
                  ] else
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: .center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.containerHorizontal,
                            ),
                            child: placeholder,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          floatingActionButton: isEmpty
              ? null
              : AddFridgeProductButton(onPressed: () => _onFridgeFormOpened()),
          floatingActionButtonAnimator:
              FloatingActionButtonAnimator.noAnimation,
        );
      },
    );
  }
}
