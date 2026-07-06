import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/scroll/scroll.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/presentation/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/presentation/widgets/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ProductCatalogView extends StatelessWidget {
  const ProductCatalogView({super.key});

  static const double containerVerticalGap = AppSpacing.standard;
  static const double containerHorizontalPadding = AppSpacing.xLarge;
  static const double categoryChipsHeight = 36 + containerVerticalGap * 2;
  static const double searchBarHeight = 48 + containerVerticalGap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocBuilder<ProductCatalogBloc, ProductCatalogState>(
      builder: (context, state) {
        final categoryProducts = state.categoryProducts;
        final totalProducts = state.products.length;

        return SafeArea(
          child: CustomScrollView(
            physics: const NoImplicitScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: containerHorizontalPadding,
                  ),
                  child: Text(
                    l10n.productCatalogTotalWithDescription(
                      totalProducts.toString(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                delegate: SearchHeaderDelegate(
                  onChanged: (value) => context.read<ProductCatalogBloc>().add(
                    SearchQueryChanged(query: value),
                  ),
                  height: searchBarHeight,
                  paddingTop: containerVerticalGap,
                  paddingHorizontal: containerHorizontalPadding,
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: CategoryChipsHeaderDelegate(
                  height: categoryChipsHeight,
                  paddingVertical: containerVerticalGap,
                  paddingHorizontal: containerHorizontalPadding,
                  categories: state.categories,
                  selectedCategory: state.selectedCategory,
                  onCategorySelected: (category) => context
                      .read<ProductCatalogBloc>()
                      .add(SelectedCategoryChanged(category: category)),
                ),
              ),
              for (var i = 0; i < categoryProducts.length; i++) ...[
                if (i > 0)
                  const SliverToBoxAdapter(
                    child: SizedBox(height: containerVerticalGap),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: containerHorizontalPadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      categoryProducts[i].category.label.toUpperCase(),
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: containerVerticalGap),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: containerHorizontalPadding,
                  ),
                  sliver: SliverList.separated(
                    itemCount: categoryProducts[i].products.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: containerVerticalGap);
                    },
                    itemBuilder: (context, index) {
                      return ProductTile(
                        product: categoryProducts[i].products[index],
                      );
                    },
                  ),
                ),
              ],
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.xLarge),
              ),
            ],
          ),
        );
      },
    );
  }
}
