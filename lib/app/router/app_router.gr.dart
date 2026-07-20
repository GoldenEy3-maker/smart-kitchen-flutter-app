// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
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
