import "package:flutter/widgets.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

class FormItem extends StatelessWidget {
  const FormItem({
    required this.child,
    super.key,
    this.label,
    this.errorMessage,
  });
  final Widget child;
  final Widget? label;
  final Widget? errorMessage;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final text = context.theme.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          DefaultTextStyle(
            style: text.labelSm.copyWith(color: colors.textPrimary),
            child: label!,
          ),
          const SizedBox(height: AppSpacing.small),
        ],
        child,
        if (errorMessage != null) ...[
          const SizedBox(height: AppSpacing.small),
          DefaultTextStyle(
            style: text.labelXs.copyWith(color: colors.dangerText),
            child: errorMessage!,
          ),
        ],
      ],
    );
  }
}
