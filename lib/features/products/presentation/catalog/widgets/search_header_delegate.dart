import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input_shapes.dart";

class SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final double paddingTop;
  final double paddingHorizontal;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;

  const SearchHeaderDelegate({
    required this.height,
    this.paddingTop = 0,
    this.paddingHorizontal = 0,
    this.controller,
    this.onChanged,
  });

  static double kHeight = InputShapes.circular.height;

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
      child: Input(
        controller: controller,
        onChanged: onChanged,
        shape: InputShapes.circular,
        hintText: l10n.productCatalogSearchHint,
        prefixIcon: const Icon(LucideIcons.search, size: 20),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SearchHeaderDelegate oldDelegate) {
    return false;
  }
}
