import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/icons/catalog_icons.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/scroll_sheet_to_item.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";

const double _initialSheetSize = 0.53;
const double _maxSheetSize = 0.9;

Future<CatalogIcons?> showCatalogIconsPickerSheet({
  required BuildContext context,
  CatalogIcons? initialSelectedCatalogIcon,
}) async {
  return showResizableSheet<CatalogIcons?>(
    context: context,
    initialSize: _initialSheetSize,
    maxSize: _maxSheetSize,
    fitMaxSizeToContent: true,
    builder: (context, scrollController, sheetController) =>
        CatalogIconsPickerSheetView(
          scrollController: scrollController,
          sheetController: sheetController,
          initialSelectedCatalogIcon: initialSelectedCatalogIcon,
        ),
  );
}

class CatalogIconsPickerSheetView extends StatefulWidget {
  const CatalogIconsPickerSheetView({
    required this.scrollController,
    required this.sheetController,
    super.key,
    this.initialSelectedCatalogIcon,
  });

  final ScrollController scrollController;

  final DraggableScrollableController sheetController;

  final CatalogIcons? initialSelectedCatalogIcon;

  @override
  State<CatalogIconsPickerSheetView> createState() =>
      _CatalogIconsPickerSheetViewState();
}

class _CatalogIconsPickerSheetViewState
    extends State<CatalogIconsPickerSheetView> {
  static const int _crossAxisCount = 5;
  late final ValueNotifier<CatalogIcons?> _selectedCatalogIcon = ValueNotifier(
    widget.initialSelectedCatalogIcon,
  );

  /// Makes the initially selected icon visible when the sheet opens: expands
  /// the sheet to its max snap position and scrolls the grid to the icon.
  Future<void> _scrollToInitialSelectedCatalogIcon() async {
    final selectedCatalogIcon = _selectedCatalogIcon.value;
    if (selectedCatalogIcon == null) {
      return;
    }

    final crossAxisExtent = scrollableCrossAxisExtent(widget.scrollController);
    if (crossAxisExtent == null) {
      return;
    }

    await scrollSheetToItem(
      scrollController: widget.scrollController,
      sheetController: widget.sheetController,
      index: CatalogIcons.values.indexOf(selectedCatalogIcon),
      itemExtent: gridItemExtent(
        crossAxisExtent: crossAxisExtent,
        crossAxisCount: _crossAxisCount,
        crossAxisSpacing: AppSpacing.medium,
      ),
      maxSheetSize: _maxSheetSize,
      crossAxisCount: _crossAxisCount,
      mainAxisSpacing: AppSpacing.medium,
    );
  }

  set _selectedCatalogIcon(CatalogIcons? catalogIcon) {
    _selectedCatalogIcon.value = catalogIcon;
  }

  void _onClose(BuildContext context) {
    Navigator.pop(context, _selectedCatalogIcon.value);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _scrollToInitialSelectedCatalogIcon();
    });
  }

  @override
  void dispose() {
    _selectedCatalogIcon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.theme.colors;
    final text = context.theme.text;
    final buttonStyles = ButtonStyles.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.containerHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: colors.surface,
            padding: const EdgeInsets.only(
              top: AppSpacing.xLarge,
              bottom: AppSpacing.standard,
            ),
            child: Text(l10n.selectProductIcon, style: text.headingLg),
          ),
          Expanded(
            child: CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                ValueListenableBuilder(
                  valueListenable: _selectedCatalogIcon,
                  builder: (context, selectedCatalogIcon, child) {
                    return SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _crossAxisCount,
                            mainAxisSpacing: AppSpacing.medium,
                            crossAxisSpacing: AppSpacing.medium,
                          ),
                      itemBuilder: (context, index) {
                        final catalogIcon = CatalogIcons.values[index];
                        final isSelected = catalogIcon == selectedCatalogIcon;

                        return Button(
                          size: ButtonSizes.icon,
                          style: isSelected
                              ? buttonStyles.secondarySelected
                              : buttonStyles.secondary,
                          rounder: ButtonRounders.rectangular.copyWith(
                            borderRadius: BorderRadius.circular(
                              AppRadius.smallX,
                            ),
                          ),
                          onPressed: () {
                            _selectedCatalogIcon = catalogIcon;
                          },
                          child: Icon(
                            CatalogIcons.values[index].icon,
                            size: 22,
                          ),
                        );
                      },
                      itemCount: CatalogIcons.values.length,
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            color: colors.surface,
            padding: const EdgeInsets.only(top: AppSpacing.medium),
            child: Button(
              onPressed: () {
                _onClose(context);
              },
              child: Text(l10n.select, textAlign: .center),
            ),
          ),
        ],
      ),
    );
  }
}
