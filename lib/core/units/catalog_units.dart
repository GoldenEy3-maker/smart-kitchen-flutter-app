import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/context/context.dart";

class CatalogUnitsLabels {
  const CatalogUnitsLabels({required this.full, required this.short});

  final String full;
  final String short;
}

enum CatalogUnits {
  piece,
  gram,
  kilogram,
  milliliter,
  liter;

  static const CatalogUnits fallback = CatalogUnits.piece;

  static CatalogUnitsLabels resolveLabels({
    required BuildContext context,
    required CatalogUnits unit,
  }) {
    final l10n = context.l10n;

    return switch (unit) {
      CatalogUnits.piece => CatalogUnitsLabels(
        full: l10n.unit_fullPiece,
        short: l10n.unit_shortPiece,
      ),
      CatalogUnits.gram => CatalogUnitsLabels(
        full: l10n.unit_fullGram,
        short: l10n.unit_shortGram,
      ),
      CatalogUnits.kilogram => CatalogUnitsLabels(
        full: l10n.unit_fullKilogram,
        short: l10n.unit_shortKilogram,
      ),
      CatalogUnits.milliliter => CatalogUnitsLabels(
        full: l10n.unit_fullMilliliter,
        short: l10n.unit_shortMilliliter,
      ),
      CatalogUnits.liter => CatalogUnitsLabels(
        full: l10n.unit_fullLiter,
        short: l10n.unit_shortLiter,
      ),
    };
  }

  static CatalogUnits fromName(String? name) =>
      values.asNameMap()[name] ?? fallback;
}
