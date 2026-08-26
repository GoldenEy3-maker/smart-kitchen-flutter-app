import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";

class CreateProductButton extends StatelessWidget {
  const CreateProductButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final buttonStyles = ButtonStyles.of(context);

    return Button(
      style: buttonStyles.primary.copyWith(
        elevation: 6,
        shadowColor: colors.primary.withValues(alpha: 0.35),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.small,
        children: [
          const Icon(LucideIcons.plus, size: 20),
          Text(l10n.newProduct),
        ],
      ),
    );
  }
}
