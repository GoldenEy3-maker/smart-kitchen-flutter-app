import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";

class AddFridgeProductButton extends StatelessWidget {
  const AddFridgeProductButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Button(
      onPressed: onPressed,
      style: ButtonStyles.primary.copyWith(
        elevation: 6,
        shadowColor: AppColors.primary.withValues(alpha: 0.35),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.small,
        children: [Icon(LucideIcons.plus), Text(l10n.addFridgeProduct)],
      ),
    );
  }
}
