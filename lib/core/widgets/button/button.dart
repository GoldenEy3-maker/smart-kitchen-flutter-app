import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart"
    as button_styles;

import "button_sizes.dart";
import "button_size.dart" as button_sizes;
import "button_styles.dart";

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final button_styles.ButtonStyle? style;
  final button_sizes.ButtonSize? size;

  const Button({
    super.key,
    required this.child,
    required this.onPressed,
    this.style,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = style ?? ButtonStyles.primary;
    final resolvedSize = size ?? ButtonSizes.primary;
    final resolvedTextStyle =
        resolvedStyle.textStyle ??
        AppTypography.textTheme.labelMedium!.copyWith(
          color: resolvedStyle.foregroundColor,
          fontSize: 16,
        );
    final resolvedShape = resolvedStyle.shape ?? BoxShape.rectangle;
    final isCircle = resolvedShape == BoxShape.circle;
    final isFixedSize = resolvedSize.minWidth > 0;

    final content = Padding(
      padding: resolvedSize.padding,
      child: IconTheme.merge(
        data: IconThemeData(color: resolvedStyle.foregroundColor),
        child: DefaultTextStyle(style: resolvedTextStyle, child: child),
      ),
    );

    final material = Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: resolvedStyle.borderRadius,
          color: resolvedStyle.backgroundColor,
          shape: resolvedShape,
          border: resolvedStyle.border,
        ),
        child: InkWell(
          onTap: onPressed,
          customBorder: isCircle
              ? const CircleBorder()
              : (resolvedStyle.borderRadius != null
                    ? RoundedRectangleBorder(
                        borderRadius: resolvedStyle.borderRadius!,
                      )
                    : null),
          child: content,
        ),
      ),
    );

    if (isFixedSize) {
      return SizedBox(
        width: resolvedSize.minWidth,
        height: resolvedSize.minHeight,
        child: material,
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: resolvedSize.minHeight),
      child: material,
    );
  }
}
