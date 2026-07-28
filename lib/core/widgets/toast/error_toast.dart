import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

class ErrorToast extends StatelessWidget {
  const ErrorToast({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.dangerSoft,
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            color: AppColors.danger.withValues(alpha: 0.25),
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.small,
        children: [
          Icon(LucideIcons.circleX, color: AppColors.dangerText),
          Flexible(
            child: Text(message, style: AppTypography.textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
