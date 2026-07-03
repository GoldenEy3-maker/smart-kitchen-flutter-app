import "package:auto_route/auto_route.dart";
import "package:smart_kitchen_flutter_app/app/pages/pages.dart";

part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: ProductCatalogRoute.page, initial: true),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
