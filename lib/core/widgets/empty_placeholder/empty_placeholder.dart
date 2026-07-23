import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({
    super.key,
    this.icon,
    required this.title,
    this.description,
    this.action,
  });

  final Widget? icon;
  final String title;
  final String? description;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final resolvedIcon =
        icon ?? Icon(LucideIcons.bookOpen, size: 40, color: AppColors.primary);
    return Column(
      spacing: AppSpacing.large,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.iconBg,
          ),
          child: resolvedIcon,
        ),
        Text(
          title,
          style: AppTypography.textTheme.titleLarge!.copyWith(
            fontFamily: AppFonts.manrope,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        if (description != null)
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 280),
            child: Text(
              description!,
              style: AppTypography.textTheme.bodyMedium!.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ?action,
      ],
    );
  }
}
