import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";

class SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  const SearchHeaderDelegate({
    required this.height,
    required this.hintText,
    this.paddingTop = 0,
    this.paddingHorizontal = 0,
    this.controller,
    this.onChanged,
  });

  final double height;
  final double paddingTop;
  final double paddingHorizontal;
  final String hintText;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;

  static double kHeight = AppInputShapes.circular.height;

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
    final theme = Theme.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.only(
        top: paddingTop,
        left: paddingHorizontal,
        right: paddingHorizontal,
      ),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        onChanged: onChanged,
        decoration: AppInputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(LucideIcons.search, size: 20),
          shape: AppInputShapes.circular,
        ).toInputDecoration(),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SearchHeaderDelegate oldDelegate) {
    return false;
  }
}
