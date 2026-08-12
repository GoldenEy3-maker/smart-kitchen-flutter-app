import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

class FormItem extends StatelessWidget {
  final Widget child;
  final Widget? label;
  final Widget? errorMessage;

  const FormItem({
    super.key,
    required this.child,
    this.label,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          DefaultTextStyle(
            style: AppTypography.textTheme.labelMedium!.copyWith(
              color: colors.textPrimary,
            ),
            child: label!,
          ),
          const SizedBox(height: AppSpacing.small),
        ],
        child,
        if (errorMessage != null) ...[
          const SizedBox(height: AppSpacing.small),
          DefaultTextStyle(
            style: AppTypography.textTheme.labelSmall!.copyWith(
              color: colors.dangerText,
            ),
            child: errorMessage!,
          ),
        ],
      ],
    );
  }
}
