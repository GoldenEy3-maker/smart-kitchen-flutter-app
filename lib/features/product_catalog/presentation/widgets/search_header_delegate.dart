import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";

class SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final double paddingTop;
  final double paddingHorizontal;

  const SearchHeaderDelegate({
    required this.height,
    this.paddingTop = 0,
    this.paddingHorizontal = 0,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => minExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.only(
        top: paddingTop,
        left: paddingHorizontal,
        right: paddingHorizontal,
      ),
      child: TextField(
        scrollPadding: EdgeInsets.zero,
        decoration: InputDecoration(
          hintText: l10n.productCatalogSearchHint,
          prefixIcon: Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Icon(Icons.search),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SearchHeaderDelegate oldDelegate) {
    return false;
  }
}
