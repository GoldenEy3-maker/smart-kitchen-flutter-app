import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";

class ErrorPlaceholder extends StatefulWidget {
  const ErrorPlaceholder({
    super.key,
    required this.errorMessage,
    required this.onTryAgain,
  });

  final String errorMessage;
  final Future<void> Function() onTryAgain;

  @override
  State<ErrorPlaceholder> createState() => _ErrorPlaceholderState();
}

class _ErrorPlaceholderState extends State<ErrorPlaceholder> {
  final ValueNotifier<bool> _isTryAgainPending = ValueNotifier(false);

  Future<void> _onTryAgainPressed() async {
    _isTryAgainPending.value = true;
    await widget.onTryAgain();
    _isTryAgainPending.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final text = context.theme.text;
    final resolvedIcon = Icon(
      LucideIcons.xCircle,
      size: 40,
      color: colors.dangerText,
    );
    return Column(
      spacing: AppSpacing.large,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.iconBg,
          ),
          child: resolvedIcon,
        ),
        Text(
          l10n.error,
          style: text.headingLg.copyWith(color: colors.textPrimary),
          textAlign: TextAlign.center,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 280),
          child: Text(
            widget.errorMessage,
            style: text.bodySm.copyWith(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _isTryAgainPending,
          builder: (context, isTryAgainPending, child) {
            return Button(
              onPressed: _onTryAgainPressed,
              disabled: isTryAgainPending,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: .min,
                spacing: AppSpacing.small,
                children: [
                  Icon(LucideIcons.rotateCcw, size: 16),
                  Text(l10n.tryAgain),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
