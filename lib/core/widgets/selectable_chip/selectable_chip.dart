import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

class SelectableChip extends StatelessWidget {
  final Widget label;
  final bool? selected;
  final void Function(bool selected)? onSelected;

  const SelectableChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selected == true;
    final Color foregroundColor = isSelected
        ? AppColors.onPrimary
        : AppColors.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onSelected?.call(!selected!),
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.medium)),
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            border: Border.all(
              color: isSelected ? Colors.transparent : AppColors.border,
            ),
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.medium)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.standard,
              vertical: AppSpacing.small,
            ),
            child: IconTheme.merge(
              data: IconThemeData(color: foregroundColor),
              child: DefaultTextStyle.merge(
                style: AppTypography.textTheme.labelMedium!.copyWith(
                  color: foregroundColor,
                ),
                child: label,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
