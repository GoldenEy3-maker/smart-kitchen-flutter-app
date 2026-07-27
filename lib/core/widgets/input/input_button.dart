import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";

class InputButton extends StatelessWidget {
  const InputButton({
    super.key,
    required this.onPressed,
    this.hintText = "",
    this.value,
  });

  final VoidCallback onPressed;
  final String hintText;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final inputDecoration = AppInputDecoration(hintText: hintText);

    return Material(
      color: inputDecoration.style.fillColor,
      shape: RoundedRectangleBorder(
        borderRadius: inputDecoration.shape.borderRadius,
        side: BorderSide(
          color: inputDecoration.style.borderColor ?? Colors.transparent,
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        customBorder: RoundedRectangleBorder(
          borderRadius: inputDecoration.shape.borderRadius,
        ),
        child: Padding(
          padding: inputDecoration.shape.contentPadding,
          child: Row(
            spacing: AppSpacing.small,
            children: [
              Expanded(
                child: value != null
                    ? Text(
                        value!,
                        style: AppTypography.textTheme.bodyLarge!.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      )
                    : Text(hintText, style: inputDecoration.style.hintStyle),
              ),
              Icon(
                LucideIcons.chevronDown,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
