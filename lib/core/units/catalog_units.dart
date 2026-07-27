import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";

class CatalogUnitsLabels {
  const CatalogUnitsLabels({required this.full, required this.short});

  final String full;
  final String short;
}

enum CatalogUnits {
  piece,
  gram,
  milliliter,
  other;

  static const fallback = CatalogUnits.other;

  static CatalogUnitsLabels resolveLabels({
    required BuildContext context,
    required CatalogUnits unit,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return switch (unit) {
      CatalogUnits.piece => CatalogUnitsLabels(
        full: l10n.unit_fullPiece,
        short: l10n.unit_shortPiece,
      ),
      CatalogUnits.gram => CatalogUnitsLabels(
        full: l10n.unit_fullGram,
        short: l10n.unit_shortGram,
      ),
      CatalogUnits.milliliter => CatalogUnitsLabels(
        full: l10n.unit_fullMilliliter,
        short: l10n.unit_shortMilliliter,
      ),
      CatalogUnits.other => CatalogUnitsLabels(
        full: l10n.unit_fullOther,
        short: l10n.unit_shortOther,
      ),
    };
  }

  static CatalogUnits fromName(String? name) =>
      values.asNameMap()[name] ?? fallback;
}
