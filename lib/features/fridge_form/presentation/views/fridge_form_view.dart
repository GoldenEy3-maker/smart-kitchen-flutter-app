import "package:flutter/material.dart";
import "package:lucide_icons_flutter/lucide_icons.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_rounder.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_size.dart";
import "package:smart_kitchen_flutter_app/core/widgets/button/button_style.dart";

class FridgeFormView extends StatefulWidget {
  const FridgeFormView({required this.onGoBackRequested, super.key});

  final void Function() onGoBackRequested;

  @override
  State<FridgeFormView> createState() => _FridgeFormViewState();
}

class _FridgeFormViewState extends State<FridgeFormView> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final buttonStyles = ButtonStyles.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.fridgeFormPageAppBarTitle),
        centerTitle: true,
        leadingWidth:
            ButtonSizes.iconSmall.minWidth + AppSpacing.containerHorizontal,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.containerHorizontal),
          child: Button(
            style: buttonStyles.secondary,
            size: ButtonSizes.iconSmall,
            rounder: ButtonRounders.circle,
            onPressed: () => widget.onGoBackRequested(),
            child: const Icon(LucideIcons.chevronLeft, size: 22),
          ),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: AppSpacing.large,
              left: AppSpacing.containerHorizontal,
              right: AppSpacing.containerHorizontal,
            ),
            child: Column(children: [Text("Fridge Form")]),
          ),
        ),
      ),
    );
  }
}
