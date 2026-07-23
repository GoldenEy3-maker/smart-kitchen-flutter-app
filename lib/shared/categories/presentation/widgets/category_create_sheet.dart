import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/icons/icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";
import "package:smart_kitchen_flutter_app/core/widgets/input/input.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/entities/entities.dart";

typedef CategoryCreateSheetOnCreateCallback =
    void Function(String label, String iconKey);
Future<void> showCategoryCreateSheet({
  required BuildContext context,
  required CategoryCreateSheetOnCreateCallback onCreate,
}) {
  return showResizableSheet(
    context: context,
    initialSize: 0.27,
    maxSize: 0.27,
    snap: true,
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
    super.key,
    required this.scrollController,
    required this.onCreate,
  });

  final ScrollController scrollController;
  final CategoryCreateSheetOnCreateCallback onCreate;

  @override
  State<CategoryCreateSheetView> createState() =>
      _CategoryCreateSheetViewState();
}

class _CategoryCreateSheetViewState extends State<CategoryCreateSheetView> {
  CatalogIcon? _selectedIcon;

  void _onIconSelected(CatalogIcon? icon) {
    setState(() {
      if (icon == null) return;

      _selectedIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.containerHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.only(
              top: AppSpacing.xLarge,
              bottom: AppSpacing.large,
            ),
            child: Text(
              l10n.newCategory,
              style: AppTypography.textTheme.titleLarge!.copyWith(
                fontFamily: AppFonts.manrope,
              ),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    spacing: AppSpacing.small,
                    children: [
                      Button(
                        style: ButtonStyles.secondary,
                        size: ButtonSizes.icon,
                        rounder: ButtonRounders.rectangular.copyWith(
                          borderRadius: AppInputDecoration().shape.borderRadius,
                        ),
                        onPressed: () {
                          showCatalogIconsPickerSheet(
                            context: context,
                            initialSelectedIconKey: _selectedIcon,
                          ).then(_onIconSelected);
                        },
                        child: _selectedIcon != null
                            ? Icon(_selectedIcon!.icon, size: 20)
                            : Icon(LucideIcons.tag, size: 20),
                      ),
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          decoration: AppInputDecoration(
                            hintText: l10n.name,
                          ).toInputDecoration(),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.standard),
                ),
                SliverToBoxAdapter(
                  child: Button(
                    onPressed: () {
                      widget.onCreate(
                        _selectedIcon?.name ?? "",
                        _selectedIcon?.name ?? "",
                      );
                    },
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
        ],
      ),
    );
  }
}
