import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";

/// Returns `true` to close the sheet, `false` to keep it open (e.g. on error).
typedef CategoryCreateSheetOnCreateCallback =
    Future<bool> Function(String label, String iconKey);

Future<void> showCategoryCreateSheet({
  required BuildContext context,
  required CategoryCreateSheetOnCreateCallback onCreate,
}) {
  return showResizableSheet<void>(
    context: context,
    maxSize: 0.9,
    fitToContent: true,
    builder: (context, scrollController, sheetController) {
      return CategoryCreateSheetView(
        scrollController: scrollController,
        onCreate: onCreate,
      );
    },
  );
}

class CategoryCreateSheetView extends StatefulWidget {
  const CategoryCreateSheetView({
    required this.scrollController,
    required this.onCreate,
    super.key,
  });

  final ScrollController scrollController;
  final CategoryCreateSheetOnCreateCallback onCreate;

  @override
  State<CategoryCreateSheetView> createState() =>
      _CategoryCreateSheetViewState();
}

class _CategoryCreateSheetViewState extends State<CategoryCreateSheetView> {
  final ValueNotifier<CatalogIcons?> _selectedIcon = ValueNotifier(null);
  final ValueNotifier<bool> _isPending = ValueNotifier(false);
  final TextEditingController _labelController = TextEditingController();

  set _selectedIcon(CatalogIcons? icon) {
    if (icon == null) return;
    _selectedIcon.value = icon;
  }

  Future<void> _onCreatePressed() async {
    if (_isPending.value) return;

    _isPending.value = true;
    try {
      final shouldClose = await widget.onCreate(
        _labelController.text,
        _selectedIcon.value?.name ?? "",
      );
      if (shouldClose && mounted) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        _isPending.value = false;
      }
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    _selectedIcon.dispose();
    _isPending.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final text = context.theme.text;

    final buttonStyles = ButtonStyles.of(context);
    final inputDecoration = AppInputDecoration(
      context: context,
      hintText: l10n.name,
    );

    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.containerHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: colors.surface,
              padding: const EdgeInsets.only(
                top: AppSpacing.xLarge,
                bottom: AppSpacing.standard,
              ),
              child: Text(l10n.newCategory, style: text.headingLg),
            ),

            Row(
              spacing: AppSpacing.small,
              children: [
                ValueListenableBuilder(
                  valueListenable: _selectedIcon,
                  builder: (context, icon, _) => Button(
                    style: icon != null
                        ? buttonStyles.secondarySelected
                        : buttonStyles.secondary,
                    size: ButtonSizes.icon,
                    rounder: ButtonRounders.rectangular.copyWith(
                      borderRadius: inputDecoration.shape.borderRadius,
                    ),
                    onPressed: () async {
                      final newIcon = await showCatalogIconsPickerSheet(
                        context: context,
                        initialSelectedCatalogIcon: icon,
                      );

                      _selectedIcon = newIcon;
                    },
                    child: icon != null
                        ? Icon(icon.icon, size: 20)
                        : const Icon(LucideIcons.tag, size: 20),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _labelController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: inputDecoration.toInputDecoration(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.standard),
            ListenableBuilder(
              listenable: Listenable.merge([
                _selectedIcon,
                _labelController,
                _isPending,
              ]),
              builder: (context, _) => Button(
                disabled:
                    _selectedIcon.value == null ||
                    _labelController.text.isEmpty ||
                    _isPending.value,
                onPressed: _onCreatePressed,
                child: Row(
                  mainAxisAlignment: .center,
                  spacing: AppSpacing.xSmall,
                  children: [Text(l10n.add)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
