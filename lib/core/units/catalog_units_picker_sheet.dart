import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/units/catalog_units.dart";
import "package:smart_kitchen_flutter_app/core/units/scroll_sheet_to_item.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";

const _initialSheetSize = 0.52;
const _maxSheetSize = 0.9;

Future<CatalogUnits?> showCatalogUnitsPickerSheet({
  required BuildContext context,
  CatalogUnits? initialSelectedUnit,
}) async {
  return await showResizableSheet<CatalogUnits>(
    context: context,
    initialSize: _initialSheetSize,
    maxSize: _maxSheetSize,
    fitMaxSizeToContent: true,
    builder: (context, scrollController, sheetController) =>
        CatalogUnitsPickerSheetView(
          scrollController: scrollController,
          sheetController: sheetController,
          initialSelectedUnit: initialSelectedUnit,
        ),
  );
}

class CatalogUnitsPickerSheetView extends StatefulWidget {
  const CatalogUnitsPickerSheetView({
    super.key,
    required this.scrollController,
    required this.sheetController,
    required this.initialSelectedUnit,
  });

  final ScrollController scrollController;
  final DraggableScrollableController sheetController;
  final CatalogUnits? initialSelectedUnit;

  @override
  State<CatalogUnitsPickerSheetView> createState() =>
      _CatalogUnitsPickerSheetViewState();
}

class _CatalogUnitsPickerSheetViewState
    extends State<CatalogUnitsPickerSheetView> {
  late final ValueNotifier<CatalogUnits?> _selectedUnit = ValueNotifier(
    widget.initialSelectedUnit,
  );

  void _onSelectedUnitChanged(CatalogUnits unit) {
    _selectedUnit.value = unit;
  }

  Future<void> _scrollToInitialSelectedUnit() async {
    final selectedUnit = _selectedUnit.value;
    if (selectedUnit == null) {
      return;
    }

    await scrollSheetToItem(
      scrollController: widget.scrollController,
      sheetController: widget.sheetController,
      index: CatalogUnits.values.indexOf(selectedUnit),
      itemExtent: ButtonSizes.primary.minHeight,
      maxSheetSize: _maxSheetSize,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialSelectedUnit();
    });
  }

  @override
  void dispose() {
    _selectedUnit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.containerHorizontal,
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.only(
              top: AppSpacing.xLarge,
              bottom: AppSpacing.large,
            ),
            child: Text(
              l10n.selectUnit,
              style: AppTypography.textTheme.titleLarge!.copyWith(
                fontFamily: AppFonts.manrope,
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                ValueListenableBuilder(
                  valueListenable: _selectedUnit,
                  builder: (context, value, child) {
                    return SliverList.builder(
                      itemCount: CatalogUnits.values.length,
                      itemBuilder: (context, index) {
                        final unit = CatalogUnits.values[index];
                        final isSelected = value == unit;

                        return Button(
                          onPressed: () => _onSelectedUnitChanged(unit),
                          style: isSelected
                              ? ButtonStyles.surfaceSelected
                              : ButtonStyles.surface,
                          rounder: ButtonRounders.rectangularSm,
                          child: Text(
                            (CatalogUnits.resolveLabels(
                              context: context,
                              unit: CatalogUnits.values[index],
                            ).full),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: AppColors.surface,
            padding: const EdgeInsets.only(top: AppSpacing.large),
            child: Button(
              onPressed: () {
                Navigator.pop(context, _selectedUnit.value);
              },
              child: Text(l10n.select, textAlign: .center),
            ),
          ),
        ],
      ),
    );
  }
}
