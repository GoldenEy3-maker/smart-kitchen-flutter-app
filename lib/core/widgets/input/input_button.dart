import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";

class InputButton extends StatelessWidget {
  const InputButton({
    super.key,
    required this.onPressed,
    this.hintText = "",
    this.value,
    this.invalid = false,
  });

  final VoidCallback onPressed;
  final String hintText;
  final String? value;
  final bool invalid;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    final inputDecoration = AppInputDecoration(
      context: context,
      hintText: hintText,
      invalid: invalid,
    );

    return Material(
      color: inputDecoration.style.fillColor,
      shape: RoundedRectangleBorder(
        borderRadius: inputDecoration.shape.borderRadius,
        side: BorderSide(color: inputDecoration.borderColor),
      ),
      child: InkWell(
        onTap: onPressed,
        customBorder: RoundedRectangleBorder(
          borderRadius: inputDecoration.shape.borderRadius,
        ),
        child: Padding(
          padding: inputDecoration.shape.contentPadding.copyWith(
            top: AppSpacing.medium,
            bottom: AppSpacing.medium,
          ),
          child: Row(
            spacing: AppSpacing.small,
            children: [
              Expanded(
                child: value != null
                    ? Text(
                        value!,
                        style: AppTypography.textTheme.bodyLarge!.copyWith(
                          color: colors.textPrimary,
                        ),
                      )
                    : Text(hintText, style: inputDecoration.style.hintStyle),
              ),
              Icon(
                LucideIcons.chevronDown,
                size: 18,
                color: colors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
