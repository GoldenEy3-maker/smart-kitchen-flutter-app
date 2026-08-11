import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

import "app_bottom_navigation_bar_item.dart";

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  static const _duration = Duration(milliseconds: 300);
  static const _curve = Curves.easeInOutExpo;
  static const _itemGap = 2.0;
  static const _indicatorRadius = 24.0;

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppBottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.all(4),
      margin: EdgeInsets.only(
        left: AppSpacing.large,
        right: AppSpacing.large,
        bottom: MediaQuery.of(context).padding.bottom + AppSpacing.medium,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surfaceGlass,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            color: AppColors.shadowColor.withValues(alpha: 0.06),
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final count = items.length;
          final totalGaps = _itemGap * (count - 1);
          final itemWidth = (constraints.maxWidth - totalGaps) / count;
          final indicatorLeft = currentIndex * (itemWidth + _itemGap);

          return Stack(
            children: [
              AnimatedPositioned(
                duration: _duration,
                curve: _curve,
                left: indicatorLeft,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(_indicatorRadius),
                  ),
                ),
              ),
              Row(
                spacing: _itemGap,
                children: [
                  for (var i = 0; i < count; i++)
                    Expanded(
                      child: AppBottomNavigationBarItem(
                        icon: items[i].icon,
                        label: items[i].label,
                        isSelected: i == currentIndex,
                        onTap: onTap,
                        index: i,
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
