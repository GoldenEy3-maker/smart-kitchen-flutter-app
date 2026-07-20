import "package:flutter/material.dart";
import "package:skeletonizer/skeletonizer.dart";
import "package:smart_kitchen_flutter_app/features/products/navigation/navigation.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_sizes.dart";
import "package:smart_kitchen_flutter_app/core/widgets/scroll/scroll.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/catalog/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/catalog/widgets/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ProductCatalogViewConfig {
  static const double verticalGap = AppSpacing.standard;
  static const double horizontalPadding = AppSpacing.xLarge;

  static double categoryChipsHeight =
      CategoryChipsHeaderDelegate.kHeight + verticalGap * 2;
  static double searchBarHeight = SearchHeaderDelegate.kHeight;
  static double safeFooterHeight =
      AppSpacing.large * 2 + ButtonSizes.primary.minHeight;
}

class ProductCatalogView extends StatelessWidget {
  final ProductsNavigator navigator;
  const ProductCatalogView({super.key, required this.navigator});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCatalogBloc, ProductCatalogState>(
      builder: (context, state) {
        final categoryProducts = state.isLoading
            ? [
                CategoryProduct.loading,
                CategoryProduct.loading,
                CategoryProduct.loading,
              ]
            : state.categoryProducts;

        return SafeArea(
          child: CustomScrollView(
            physics: const NoImplicitScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverPersistentHeader(
                floating: true,
                delegate: SearchHeaderDelegate(
                  onChanged: (value) => context.read<ProductCatalogBloc>().add(
                    SearchQueryChanged(query: value),
                  ),
                  height: ProductCatalogViewConfig.searchBarHeight,
                  // paddingTop: containerVerticalGap,
                  paddingHorizontal: ProductCatalogViewConfig.horizontalPadding,
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: CategoryChipsHeaderDelegate(
                  height: ProductCatalogViewConfig.categoryChipsHeight,
                  paddingVertical: ProductCatalogViewConfig.verticalGap,
                  paddingHorizontal: ProductCatalogViewConfig.horizontalPadding,
                  isLoading: state.isLoading,
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
                    child: SizedBox(
                      height: ProductCatalogViewConfig.verticalGap,
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ProductCatalogViewConfig.horizontalPadding,
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
                  child: SizedBox(height: ProductCatalogViewConfig.verticalGap),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ProductCatalogViewConfig.horizontalPadding,
                  ),
                  sliver: SliverList.separated(
                    itemCount: categoryProducts[i].products.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: ProductCatalogViewConfig.verticalGap,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Skeletonizer(
                        enabled: state.isLoading,
                        child: ProductTile(
                          navigator: navigator,
                          product: categoryProducts[i].products[index],
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
            ],
          ),
        );
      },
    );
  }
}
