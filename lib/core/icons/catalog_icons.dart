import "package:flutter/widgets.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";

enum CatalogIcons {
  broccoli(LucideIcons.broccoli),
  carrot(LucideIcons.carrot),
  apple(LucideIcons.apple),
  beef(LucideIcons.beef),
  fish(LucideIcons.fish),
  milk(LucideIcons.milk),
  wheat(LucideIcons.wheat),
  croissant(LucideIcons.croissant),
  cupSoda(LucideIcons.cupSoda),
  wine(LucideIcons.wine),
  snowflake(LucideIcons.snowflake),
  egg(LucideIcons.egg),
  beer(LucideIcons.beer),
  hamburger(LucideIcons.hamburger),
  salad(LucideIcons.salad),
  amphora(LucideIcons.amphora),
  banana(LucideIcons.banana),
  barrel(LucideIcons.barrel),
  bean(LucideIcons.bean),
  blender(LucideIcons.blender),
  bottleWine(LucideIcons.bottleWine),
  cake(LucideIcons.cake),
  cakeSlice(LucideIcons.cakeSlice),
  candy(LucideIcons.candy),
  candyCane(LucideIcons.candyCane),
  chefHat(LucideIcons.chefHat),
  cherry(LucideIcons.cherry),
  citrus(LucideIcons.citrus),
  coffee(LucideIcons.coffee),
  cookie(LucideIcons.cookie),
  cookingPot(LucideIcons.cookingPot),
  cuboid(LucideIcons.cuboid),
  dessert(LucideIcons.dessert),
  donut(LucideIcons.donut),
  drumstick(LucideIcons.drumstick),
  eggFried(LucideIcons.eggFried),
  glassWater(LucideIcons.glassWater),
  grape(LucideIcons.grape),
  ham(LucideIcons.ham),
  handPlatter(LucideIcons.handPlatter),
  hop(LucideIcons.hop),
  iceCreamBowl(LucideIcons.iceCreamBowl),
  iceCreamCone(LucideIcons.iceCreamCone),
  leafyGreen(LucideIcons.leafyGreen),
  lollipop(LucideIcons.lollipop),
  martini(LucideIcons.martini),
  microwave(LucideIcons.microwave),
  nut(LucideIcons.nut),
  pizza(LucideIcons.pizza),
  popcorn(LucideIcons.popcorn),
  popsicle(LucideIcons.popsicle),
  refrigerator(LucideIcons.refrigerator),
  sandwich(LucideIcons.sandwich),
  shell(LucideIcons.shell),
  snail(LucideIcons.snail),
  soup(LucideIcons.soup),
  torus(LucideIcons.torus),
  tractor(LucideIcons.tractor),
  utensils(LucideIcons.utensils),
  utensilsCrossed(LucideIcons.utensilsCrossed),
  vegan(LucideIcons.vegan),
  package(LucideIcons.package);

  const CatalogIcons(this.icon);

  static const CatalogIcons fallback = CatalogIcons.package;

  final IconData icon;

  static CatalogIcons fromName(String? name) =>
      values.asNameMap()[name] ?? fallback;
}
