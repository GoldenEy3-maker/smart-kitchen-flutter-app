import "package:flutter/material.dart";
import "package:auto_route/auto_route.dart";
import "package:smart_kitchen_flutter_app/app/pages/pages.dart";
import "package:smart_kitchen_flutter_app/app/layouts/layouts.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";

part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: "/",
      page: MainLayoutRoute.page,
      children: [
        AutoRoute(page: FridgeCatalogRoute.page, initial: true),
        AutoRoute(page: BasketRoute.page),
        AutoRoute(page: MenuRoute.page),
        AutoRoute(page: RecipesCatalogRoute.page),
      ],
    ),
    AutoRoute(page: FridgeFormRoute.page),
    AutoRoute(page: ProductCatalogRoute.page),
    AutoRoute(page: ProductFormRoute.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
