import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/units/scroll_sheet_to_item.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/resizable_sheet/show_resizable_sheet.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/category_with_products_count.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/form/bloc/bloc.dart";
import "package:smart_kitchen_flutter_app/features/products/presentation/form/widgets/widgets.dart";
import 'package:fluttertoast/fluttertoast.dart';

const _maxSheetSize = 0.9;
const _initialSheetSize = 0.46;

typedef CategoryManagerSheetOnDelete =
    Future<bool> Function(CategoryWithProductsCount category);

Future<CategoryWithProductsCount?> showCategoryManagerSheet({
  required BuildContext context,
  required ProductFormBloc bloc,
  CategoryWithProductsCount? initialSelectedCategory,
}) async {
  return showResizableSheet(
    context: context,
    initialSize: _initialSheetSize,
    maxSize: _maxSheetSize,
    fitMaxSizeToContent: true,
    builder: (context, scrollController, sheetController) => BlocProvider.value(
      value: bloc,
      child: CategoryManagerSheetView(
        scrollController: scrollController,
        sheetController: sheetController,
        initialSelectedCategory: initialSelectedCategory,
      ),
    ),
  );
}

class CategoryManagerSheetView extends StatefulWidget {
  const CategoryManagerSheetView({
    super.key,
    required this.scrollController,
    required this.sheetController,
    required this.initialSelectedCategory,
  });

  final ScrollController scrollController;
  final DraggableScrollableController sheetController;
  final CategoryWithProductsCount? initialSelectedCategory;

  @override
  State<CategoryManagerSheetView> createState() =>
      _CategoryManagerSheetViewState();
}

class _CategoryManagerSheetViewState extends State<CategoryManagerSheetView> {
  late FToast fToast;
  late final ValueNotifier<CategoryWithProductsCount?> _selectedCategory =
      ValueNotifier(widget.initialSelectedCategory);

  void _onCategorySelected(CategoryWithProductsCount category) {
    _selectedCategory.value = category;
  }

  void _onSelectPressed() {
    Navigator.pop(context, _selectedCategory.value);
  }

  void _onEditPressed(CategoryWithProductsCount category) {
    final bloc = context.read<ProductFormBloc>();
    final l10n = AppLocalizations.of(context)!;
    showCategoryEditSheet(
      context: context,
      category: category,
      onEdit: (updatedCategory) async {
        final done = bloc.stream.firstWhere(
          (state) => !state.isEditCategoryPending,
        );
        bloc.add(ProductFormCategoryEditRequested(category: updatedCategory));
        final state = await done;
        final isSuccess = state.error == null;
        final isSelectedCategory =
            updatedCategory.id == _selectedCategory.value?.id;

        if (isSuccess && isSelectedCategory && mounted) {
          _selectedCategory.value = updatedCategory;
        }

        if (!isSuccess && mounted) {
          fToast.showToast(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: AppColors.dangerSoft,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    color: AppColors.danger.withValues(alpha: 0.25),
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.small,
                children: [
                  Icon(LucideIcons.circleX, color: AppColors.dangerText),
                  Expanded(
                    child: Text(
                      state.error!.message,
                      style: AppTypography.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 5),
            isDismissible: true,
          );
        }

        return isSuccess;
      },
    );
  }

  Future<void> _onDeletePressed(CategoryWithProductsCount category) async {
    final bloc = context.read<ProductFormBloc>();
    final result = await showCategoryDeleteSheet(
      context: context,
      category: category,
      onDelete: () async {
        final done = bloc.stream.firstWhere(
          (state) => !state.isDeleteCategoryPending,
        );
        bloc.add(ProductFormCategoryDeleteRequested(category: category));
        final state = await done;
        // TODO: add error handling
        return state.error == null;
      },
    );

    if (result == null || result == false) return;

    if (_selectedCategory.value?.id == category.id) {
      _selectedCategory.value = null;
    }

    if (bloc.state.categories.isEmpty) {
      Navigator.pop(context);
    }
  }

  Future<void> _scrollToInitialSelectedCategory() async {
    final bloc = context.read<ProductFormBloc>();
    if (widget.initialSelectedCategory == null) return;

    await scrollSheetToItem(
      scrollController: widget.scrollController,
      sheetController: widget.sheetController,
      index: bloc.state.categories.indexOf(widget.initialSelectedCategory!),
      itemExtent: CategoryTile.height,
      maxSheetSize: _maxSheetSize,
    );
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialSelectedCategory();
    });
  }

  @override
  void dispose() {
    _selectedCategory.dispose();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.only(
              top: AppSpacing.xLarge,
              bottom: AppSpacing.medium,
            ),
            child: Text(
              l10n.selectCategory,
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
                  valueListenable: _selectedCategory,
                  builder: (context, value, child) {
                    return BlocSelector<
                      ProductFormBloc,
                      ProductFormState,
                      List<CategoryWithProductsCount>
                    >(
                      selector: (state) => state.categories,
                      builder: (context, categories) {
                        return SliverList.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final isSelected = value?.id == category.id;

                            return CategoryTile(
                              key: ValueKey(category.id),
                              selected: isSelected,
                              category: category,
                              onPressed: () => _onCategorySelected(category),
                              onEditPressed: () => _onEditPressed(category),
                              onDeletePressed: () => _onDeletePressed(category),
                            );
                          },
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
            padding: const EdgeInsets.only(top: AppSpacing.medium),
            child: Button(
              onPressed: _onSelectPressed,
              child: Text(l10n.select, textAlign: .center),
            ),
          ),
        ],
      ),
    );
  }
}
