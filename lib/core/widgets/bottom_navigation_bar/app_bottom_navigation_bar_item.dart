import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

class AppBottomNavigationBarItem extends StatelessWidget {
  const AppBottomNavigationBarItem({
    required this.icon,
    required this.label,
    super.key,
    this.onTap,
    this.index = 0,
    this.isSelected = false,
  });

  final Icon icon;
  final String label;
  final int index;
  final ValueChanged<int>? onTap;
  final bool isSelected;

  static const Duration _duration = AppDuration.main;
  static const Cubic _curve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final text = context.theme.text;
    final foregroundColor = isSelected
        ? colors.primaryText
        : colors.textPrimary;

    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: InkWell(
        onTap: () => onTap?.call(index),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        child: TweenAnimationBuilder<Color?>(
          duration: _duration,
          curve: _curve,
          tween: ColorTween(end: foregroundColor),
          builder: (context, color, _) {
            return AnimatedContainer(
              duration: _duration,
              curve: _curve,
              constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? AppSpacing.standard : 0,
              ),
              decoration: const BoxDecoration(color: Colors.transparent),
              clipBehavior: Clip.antiAlias,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconTheme.merge(
                    data: IconThemeData(color: color, size: 22),
                    child: icon,
                  ),
                  Flexible(
                    child: AnimatedSwitcher(
                      duration: _duration,
                      switchInCurve: _curve,
                      switchOutCurve: _curve,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            axis: Axis.horizontal,
                            alignment: Alignment.centerLeft,
                            fixedCrossAxisSizeFactor: 1,
                            child: child,
                          ),
                        );
                      },
                      child: isSelected
                          ? Padding(
                              key: const ValueKey("nav-label"),
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                label,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: text.labelSm.copyWith(color: color),
                              ),
                            )
                          : const SizedBox.shrink(
                              key: ValueKey("nav-label-hidden"),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
