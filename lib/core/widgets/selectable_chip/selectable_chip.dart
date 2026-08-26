import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

class SelectableChip extends StatelessWidget {
  const SelectableChip({
    required this.label,
    super.key,
    this.selected = false,
    this.onSelected,
  });
  final Widget label;
  final bool? selected;
  // ignore: avoid_positional_boolean_parameters - this is a callback doesn't matter if it's not named
  final void Function(bool selected)? onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final text = context.theme.text;

    final isSelected = selected == true;
    final foregroundColor = isSelected
        ? colors.onPrimary
        : colors.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onSelected?.call(!selected!),
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.medium)),
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected ? colors.primary : colors.surface,
            border: Border.all(
              color: isSelected ? Colors.transparent : colors.border,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(AppRadius.medium),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
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
