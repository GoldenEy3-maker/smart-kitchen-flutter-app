import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";

import "catalog_icons.dart";

const double _initialSheetSize = 0.53;
const double _maxSheetSize = 0.9;

Future<CatalogIcon?> showCatalogIconsPickerSheet({
  required BuildContext context,
  CatalogIcon? initialSelectedIconKey,
}) async {
  return showResizableSheet<CatalogIcon?>(
    context: context,
    initialSize: _initialSheetSize,
    maxSize: _maxSheetSize,
    fitMaxSizeToContent: true,
    builder: (context, scrollController, sheetController) =>
        CatalogIconsPickerSheetView(
          scrollController: scrollController,
          sheetController: sheetController,
          initialSelectedIconKey: initialSelectedIconKey,
        ),
  );
}

class CatalogIconsPickerSheetView extends StatefulWidget {
  const CatalogIconsPickerSheetView({
    super.key,
    required this.scrollController,
    required this.sheetController,
    this.initialSelectedIconKey,
  });

  final ScrollController scrollController;

  final DraggableScrollableController sheetController;

  final CatalogIcon? initialSelectedIconKey;

  @override
  State<CatalogIconsPickerSheetView> createState() =>
      _CatalogIconsPickerSheetViewState();
}

class _CatalogIconsPickerSheetViewState
    extends State<CatalogIconsPickerSheetView> {
  static const int _crossAxisCount = 5;

  late CatalogIcon? _selectedIconKey = widget.initialSelectedIconKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedIcon();
    });
  }

  /// Makes the initially selected icon visible when the sheet opens: expands
  /// the sheet to its max snap position and scrolls the grid to the icon.
  Future<void> _scrollToSelectedIcon() async {
    final selectedIconKey = _selectedIconKey;
    if (!mounted ||
        selectedIconKey == null ||
        !widget.scrollController.hasClients) {
      return;
    }

    final gridWidth =
        (context.size?.width ?? 0) - AppSpacing.containerHorizontal * 2;
    if (gridWidth <= 0) {
      return;
    }

    final cellExtent =
        (gridWidth - AppSpacing.medium * (_crossAxisCount - 1)) /
        _crossAxisCount;
    final row = CatalogIcon.values.indexOf(selectedIconKey) ~/ _crossAxisCount;
    final rowTop = row * (cellExtent + AppSpacing.medium);
    final rowBottom = rowTop + cellExtent;

    // Already fully visible - nothing to do.
    if (rowBottom <= widget.scrollController.position.viewportDimension) {
      return;
    }

    // Expand the sheet to its max snap position first: once the inner list
    // is scrolled away from the top, dragging can no longer expand the
    // sheet, so it must not be left at the initial snap.
    if (widget.sheetController.isAttached) {
      await widget.sheetController.animateTo(
        _maxSheetSize,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    if (!mounted || !widget.scrollController.hasClients) {
      return;
    }

    final position = widget.scrollController.position;
    if (rowBottom <= position.viewportDimension) {
      // Expanding the sheet alone made the row visible.
      return;
    }

    // Center the selected row.
    final visibleHeight = position.viewportDimension;
    final target = (rowTop - (visibleHeight - cellExtent) / 2).clamp(
      0.0,
      position.maxScrollExtent,
    );

    await widget.scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onSelectedIconKey(CatalogIcon? iconKey) {
    setState(() {
      _selectedIconKey = iconKey;
    });
  }

  void _onClose(BuildContext context) {
    Navigator.pop(context, _selectedIconKey);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.containerHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.only(
              top: AppSpacing.xLarge,
              bottom: AppSpacing.large,
            ),
            child: Text(
              l10n.selectProductIcon,
              style: AppTypography.textTheme.titleLarge!.copyWith(
                fontFamily: AppFonts.manrope,
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    mainAxisSpacing: AppSpacing.medium,
                    crossAxisSpacing: AppSpacing.medium,
                  ),
                  itemBuilder: (context, index) {
                    final key = CatalogIcon.values[index];
                    final isSelected = key == _selectedIconKey;

                    return Button(
                      size: ButtonSizes.icon,
                      style: isSelected
                          ? ButtonStyles.secondarySelected
                          : ButtonStyles.secondary,
                      rounder: ButtonRounders.rectangular.copyWith(
                        borderRadius: BorderRadius.circular(AppRadius.smallX),
                      ),
                      onPressed: () {
                        _onSelectedIconKey(key);
                      },
                      child: Icon(CatalogIcon.values[index].icon, size: 22),
                    );
                  },
                  itemCount: CatalogIcon.values.length,
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.surface,
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
