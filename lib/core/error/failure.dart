import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";

abstract class Failure {
  const Failure();

  String localizedMessage(AppLocalizations l10n) => l10n.unknownFailure;
}

class CacheFailure extends Failure {
  const CacheFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.cacheFailure;
  }
}

class UnknownFailure extends Failure {
  const UnknownFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.unknownFailure;
  }
}
