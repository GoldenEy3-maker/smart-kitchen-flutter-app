import "dart:async";

import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

import "package:smart_kitchen_flutter_app/core/widgets/bottom_navigation_bar/app_bottom_navigation_bar_item.dart";
import "package:smart_kitchen_flutter_app/core/widgets/bottom_navigation_bar/app_bottom_navigation_bar_layout.dart";

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    super.key,
  });

  static const Duration _duration = AppDuration.main;
  static const Cubic _curve = Curves.easeInOut;
  static const _itemGap = 4.0;
  static const _indicatorRadius = 22.0;
  static const _maxWidth = 400.0;

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppBottomNavigationBarItem> items;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _indicatorController;
  late final Animation<double> _indicatorProgress;
  late int _previousIndex;

  @override
  void initState() {
    super.initState();
    _previousIndex = widget.currentIndex;
    _indicatorController = AnimationController(
      vsync: this,
      duration: AppBottomNavigationBar._duration,
      value: 1,
    );
    _indicatorProgress = CurvedAnimation(
      parent: _indicatorController,
      curve: AppBottomNavigationBar._curve,
    );
  }

  @override
  void didUpdateWidget(covariant AppBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _previousIndex = oldWidget.currentIndex;
      _indicatorController.duration = AppBottomNavigationBar._duration;
      unawaited(_indicatorController.forward(from: 0));
    }
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.large,
          right: AppSpacing.large,
          bottom: MediaQuery.of(context).padding.bottom + AppSpacing.small,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppBottomNavigationBar._maxWidth,
          ),
          child: Container(
            height: 60,
            padding: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: colors.surfaceGlass,
              borderRadius: BorderRadius.circular(AppRadius.xLarge),
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  color: colors.shadowColor.withValues(alpha: 0.06),
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: AppBottomNavigationBarLayout(
              spacing: AppBottomNavigationBar._itemGap,
              selectedIndex: widget.currentIndex,
              previousIndex: _previousIndex,
              indicatorProgress: _indicatorProgress,
              indicatorColor: colors.primarySoft,
              indicatorRadius: AppBottomNavigationBar._indicatorRadius,
              children: [
                for (var i = 0; i < widget.items.length; i++)
                  AppBottomNavigationBarItem(
                    icon: widget.items[i].icon,
                    label: widget.items[i].label,
                    isSelected: i == widget.currentIndex,
                    onTap: widget.onTap,
                    index: i,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
