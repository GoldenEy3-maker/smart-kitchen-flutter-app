// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [BasketPage]
class BasketRoute extends PageRouteInfo<void> {
  const BasketRoute({List<PageRouteInfo>? children})
    : super(BasketRoute.name, initialChildren: children);

  static const String name = 'BasketRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BasketPage();
    },
  );
}

/// generated route for
/// [FridgeCatalogPage]
class FridgeCatalogRoute extends PageRouteInfo<void> {
  const FridgeCatalogRoute({List<PageRouteInfo>? children})
    : super(FridgeCatalogRoute.name, initialChildren: children);

  static const String name = 'FridgeCatalogRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FridgeCatalogPage();
    },
  );
}

/// generated route for
/// [FridgeFormPage]
class FridgeFormRoute extends PageRouteInfo<void> {
  const FridgeFormRoute({List<PageRouteInfo>? children})
    : super(FridgeFormRoute.name, initialChildren: children);

  static const String name = 'FridgeFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FridgeFormPage();
    },
  );
}

/// generated route for
/// [MainLayoutPage]
class MainLayoutRoute extends PageRouteInfo<void> {
  const MainLayoutRoute({List<PageRouteInfo>? children})
    : super(MainLayoutRoute.name, initialChildren: children);

  static const String name = 'MainLayoutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainLayoutPage();
    },
  );
}

/// generated route for
/// [MenuPage]
class MenuRoute extends PageRouteInfo<void> {
  const MenuRoute({List<PageRouteInfo>? children})
    : super(MenuRoute.name, initialChildren: children);

  static const String name = 'MenuRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MenuPage();
    },
  );
}

/// generated route for
/// [ProductCatalogPage]
class ProductCatalogRoute extends PageRouteInfo<void> {
  const ProductCatalogRoute({List<PageRouteInfo>? children})
    : super(ProductCatalogRoute.name, initialChildren: children);

  static const String name = 'ProductCatalogRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProductCatalogPage();
    },
  );
}

/// generated route for
/// [ProductFormPage]
class ProductFormRoute extends PageRouteInfo<ProductFormRouteArgs> {
  ProductFormRoute({Key? key, Product? product, List<PageRouteInfo>? children})
    : super(
        ProductFormRoute.name,
        args: ProductFormRouteArgs(key: key, product: product),
        initialChildren: children,
      );

  static const String name = 'ProductFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductFormRouteArgs>(
        orElse: () => const ProductFormRouteArgs(),
      );
      return ProductFormPage(key: args.key, product: args.product);
    },
  );
}

class ProductFormRouteArgs {
  const ProductFormRouteArgs({this.key, this.product});

  final Key? key;

  final Product? product;

  @override
  String toString() {
    return 'ProductFormRouteArgs{key: $key, product: $product}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductFormRouteArgs) return false;
    return key == other.key && product == other.product;
  }

  @override
  int get hashCode => key.hashCode ^ product.hashCode;
}

/// generated route for
/// [RecipesCatalogPage]
class RecipesCatalogRoute extends PageRouteInfo<void> {
  const RecipesCatalogRoute({List<PageRouteInfo>? children})
    : super(RecipesCatalogRoute.name, initialChildren: children);

  static const String name = 'RecipesCatalogRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RecipesCatalogPage();
    },
  );
}
