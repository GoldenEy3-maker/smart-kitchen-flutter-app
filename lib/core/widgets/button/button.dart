import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart"
    as button_styles;

import "button_rounder.dart";
import "button_size.dart";

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final button_styles.ButtonStyle? style;
  final ButtonSize? size;
  final ButtonRounder? rounder;
  final bool disabled;

  const Button({
    super.key,
    required this.child,
    required this.onPressed,
    this.style,
    this.size,
    this.rounder,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedStyle =
        style ?? button_styles.ButtonStyles.of(context).primary;
    final resolvedSize = size ?? ButtonSizes.primary;
    final resolvedRounder = rounder ?? ButtonRounders.rectangular;
    final resolvedForegroundColor = disabled
        ? resolvedStyle.disabled?.foregroundColor ??
              resolvedStyle.foregroundColor
        : resolvedStyle.foregroundColor;
    final resolvedBackgroundColor = disabled
        ? resolvedStyle.disabled?.backgroundColor ??
              resolvedStyle.backgroundColor
        : resolvedStyle.backgroundColor;

    final textStyle = AppTypography.textTheme.labelMedium!.copyWith(
      color: resolvedForegroundColor,
      fontSize: resolvedSize.fontSize,
    );
    final resolvedShape = resolvedRounder.shape ?? BoxShape.rectangle;
    final isCircle = resolvedShape == BoxShape.circle;
    final materialShape = _materialShape(
      resolvedStyle,
      resolvedRounder,
      isCircle,
    );
    final inkBorder = isCircle
        ? const CircleBorder()
        : (resolvedRounder.borderRadius != null
              ? RoundedRectangleBorder(
                  borderRadius: resolvedRounder.borderRadius!,
                )
              : null);

    final content = Padding(
      padding: resolvedSize.padding,
      child: IconTheme.merge(
        data: IconThemeData(color: resolvedForegroundColor),
        child: DefaultTextStyle(style: textStyle, child: child),
      ),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: resolvedSize.minHeight,
        minWidth: resolvedSize.minWidth,
        maxHeight: resolvedSize.maxHeight,
        maxWidth: resolvedSize.maxWidth,
      ),
      child: Material(
        color: resolvedBackgroundColor,
        elevation: resolvedStyle.elevation,
        shadowColor: resolvedStyle.shadowColor,
        surfaceTintColor: Colors.transparent,
        shape: materialShape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          enableFeedback: !disabled,
          onTap: disabled ? null : onPressed,
          customBorder: inkBorder,
          child: content,
        ),
      ),
    );
  }

  static ShapeBorder _materialShape(
    button_styles.ButtonStyle style,
    ButtonRounder rounder,
    bool isCircle,
  ) {
    final borderSide = style.border is Border
        ? (style.border! as Border).top
        : BorderSide.none;

    if (isCircle) {
      return CircleBorder(side: borderSide);
    }

    return RoundedRectangleBorder(
      borderRadius: rounder.borderRadius ?? BorderRadius.zero,
      side: borderSide,
    );
  }
}
