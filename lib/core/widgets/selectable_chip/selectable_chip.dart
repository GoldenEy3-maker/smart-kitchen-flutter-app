import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
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
    final colors = context.theme.colors;
    final text = context.theme.text;

    final bool isSelected = selected == true;
    final Color foregroundColor = isSelected
        ? colors.onPrimary
        : colors.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onSelected?.call(!selected!),
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.medium)),
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected ? colors.primary : colors.surface,
            border: Border.all(
              color: isSelected ? Colors.transparent : colors.border,
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
                style: text.labelSm.copyWith(color: foregroundColor),
                child: label,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
