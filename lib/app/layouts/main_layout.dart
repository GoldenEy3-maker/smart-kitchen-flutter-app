import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/app/router/app_router.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/widgets/bottom_navigation_bar/app_bottom_navigation_bar.dart";
import "package:smart_kitchen_flutter_app/core/widgets/bottom_navigation_bar/app_bottom_navigation_bar_item.dart";

@RoutePage()
class MainLayoutPage extends StatelessWidget {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AutoTabsScaffold(
      routes: const [
        FridgeCatalogRoute(),
        RecipesCatalogRoute(),
        MenuRoute(),
        BasketRoute(),
        ProductCatalogRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return AppBottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) => tabsRouter.setActiveIndex(index),
          items: [
            AppBottomNavigationBarItem(
              icon: Icon(LucideIcons.refrigerator),
              label: l10n.fridge,
            ),
            AppBottomNavigationBarItem(
              icon: Icon(LucideIcons.chefHat),
              label: l10n.recipes,
            ),
            AppBottomNavigationBarItem(
              icon: Icon(LucideIcons.calendarDays),
              label: l10n.menu,
            ),
            AppBottomNavigationBarItem(
              icon: Icon(LucideIcons.shoppingBasket),
              label: l10n.basket,
            ),
            AppBottomNavigationBarItem(
              icon: Icon(LucideIcons.layoutGrid),
              label: l10n.catalog,
            ),
          ],
        );
      },
    );
  }
}
