import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";

sealed class FridgeFailure extends Failure {
  const FridgeFailure();
}

class FridgeReadProductsCacheFailure extends FridgeFailure {
  const FridgeReadProductsCacheFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.fridgeReadProductsCacheFailure;
  }
}

class FridgeProductNotFoundFailure extends FridgeFailure {
  const FridgeProductNotFoundFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.fridgeProductNotFoundFailure;
  }
}
