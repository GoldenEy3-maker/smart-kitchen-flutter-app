import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";

import "catalog_icons.dart";

Future<CatalogIconsKey?> showSelectableCatalogIconsSheet({
  required BuildContext context,
}) async {
  return showResizableSheet<CatalogIconsKey>(
    context: context,
    initialSize: 0.53,
    maxSize: 0.9,
    snap: true,
    fitMaxSizeToContent: true,
    builder: (context, scrollController) =>
        SelectableCatalogIconsSheetView(scrollController: scrollController),
  );
}

class SelectableCatalogIconsSheetView extends StatelessWidget {
  const SelectableCatalogIconsSheetView({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

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
          Expanded(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                PinnedHeaderSliver(
                  child: Container(
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
                ),
                SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: AppSpacing.medium,
                    crossAxisSpacing: AppSpacing.medium,
                  ),
                  itemBuilder: (context, index) => Button(
                    size: ButtonSizes.icon,
                    style: ButtonStyles.secondary,
                    rounder: ButtonRounders.rectangular.copyWith(
                      borderRadius: BorderRadius.circular(AppRadius.smallX),
                    ),
                    onPressed: () {
                      Navigator.pop(context, CatalogIconsKey.values[index]);
                    },
                    child: Icon(
                      CatalogIcons.resolveByKey(
                        CatalogIconsKey.values[index].name,
                      ),
                      size: 22,
                    ),
                  ),
                  itemCount: CatalogIconsKey.values.length,
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.only(
              top: AppSpacing.medium,
              bottom: AppSpacing.medium,
            ),
            child: Button(
              onPressed: () {},
              child: Text(l10n.select, textAlign: .center),
            ),
          ),
        ],
      ),
    );
  }
}
