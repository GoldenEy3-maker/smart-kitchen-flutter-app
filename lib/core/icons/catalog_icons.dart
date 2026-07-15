import "package:flutter/widgets.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";

enum CatalogIconsKeys {
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
  static const CatalogIconsKeys fallbackIconKey = CatalogIconsKeys.package;

  static const Map<CatalogIconsKeys, IconData> _icons = {
    CatalogIconsKeys.broccoli: LucideIcons.broccoli,
    CatalogIconsKeys.carrot: LucideIcons.carrot,
    CatalogIconsKeys.apple: LucideIcons.apple,
    CatalogIconsKeys.beef: LucideIcons.beef,
    CatalogIconsKeys.fish: LucideIcons.fish,
    CatalogIconsKeys.milk: LucideIcons.milk,
    CatalogIconsKeys.wheat: LucideIcons.wheat,
    CatalogIconsKeys.croissant: LucideIcons.croissant,
    CatalogIconsKeys.cupSoda: LucideIcons.cupSoda,
    CatalogIconsKeys.wine: LucideIcons.wine,
    CatalogIconsKeys.snowflake: LucideIcons.snowflake,
    CatalogIconsKeys.egg: LucideIcons.egg,
    CatalogIconsKeys.salad: LucideIcons.salad,
    CatalogIconsKeys.beer: LucideIcons.beer,
    CatalogIconsKeys.hamburger: LucideIcons.hamburger,
    CatalogIconsKeys.package: LucideIcons.package,
  };

  static IconData resolveByKey(String key) {
    return _icons[CatalogIconsKeys.values.byName(key)] ?? LucideIcons.package;
  }
}
