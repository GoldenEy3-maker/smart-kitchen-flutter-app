import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/app_colors.dart";
import "package:smart_kitchen_flutter_app/core/theme/app_spacing.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";

class CreateProductButton extends StatelessWidget {
  const CreateProductButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Button(
      style: ButtonStyles.primary.copyWith(
        elevation: 6,
        shadowColor: AppColors.primary.withValues(alpha: 0.35),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.small,
        children: [Icon(LucideIcons.plus, size: 20), Text(l10n.newProduct)],
      ),
    );
  }
}
