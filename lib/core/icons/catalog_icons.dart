import "package:flutter/widgets.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";

enum CatalogIconsKey {
  broccoli,
  carrot,
  apple,
  beef,
  fish,
  milk,
  wheat,
  croissant,
  cupSoda,
  wine,
  snowflake,
  egg,
  beer,
  hamburger,
  salad,
  package,
}

class CatalogIcons {
  static const CatalogIconsKey fallbackIconKey = CatalogIconsKey.package;

  static const Map<CatalogIconsKey, IconData> _icons = {
    CatalogIconsKey.broccoli: LucideIcons.broccoli,
    CatalogIconsKey.carrot: LucideIcons.carrot,
    CatalogIconsKey.apple: LucideIcons.apple,
    CatalogIconsKey.beef: LucideIcons.beef,
    CatalogIconsKey.fish: LucideIcons.fish,
    CatalogIconsKey.milk: LucideIcons.milk,
    CatalogIconsKey.wheat: LucideIcons.wheat,
    CatalogIconsKey.croissant: LucideIcons.croissant,
    CatalogIconsKey.cupSoda: LucideIcons.cupSoda,
    CatalogIconsKey.wine: LucideIcons.wine,
    CatalogIconsKey.snowflake: LucideIcons.snowflake,
    CatalogIconsKey.egg: LucideIcons.egg,
    CatalogIconsKey.salad: LucideIcons.salad,
    CatalogIconsKey.beer: LucideIcons.beer,
    CatalogIconsKey.hamburger: LucideIcons.hamburger,
    CatalogIconsKey.package: LucideIcons.package,
  };

  static IconData resolveByKey(String key) {
    return _icons[CatalogIconsKey.values.byName(key)] ?? LucideIcons.package;
  }
}
