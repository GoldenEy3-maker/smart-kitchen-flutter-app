import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

class AppBottomNavigationBarItem extends StatelessWidget {
  const AppBottomNavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.index = 0,
    this.isSelected = false,
  });

  final Icon icon;
  final String label;
  final int index;
  final ValueChanged<int>? onTap;
  final bool isSelected;

  static const _duration = Duration(milliseconds: 300);
  static const _curve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final foregroundColor = isSelected
        ? colors.primaryText
        : colors.textPrimary;

    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: () => onTap?.call(index),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: TweenAnimationBuilder<Color?>(
          duration: _duration,
          curve: _curve,
          tween: ColorTween(end: foregroundColor),
          builder: (context, color, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconTheme.merge(
                  data: IconThemeData(color: color),
                  child: icon,
                ),
                Text(
                  label,
                  style: AppTypography.textTheme.labelSmall!.copyWith(
                    color: color,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
