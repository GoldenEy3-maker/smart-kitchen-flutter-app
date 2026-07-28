import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";

sealed class CategoriesFailure extends Failure {
  const CategoriesFailure();
}

class CategoriesNotFoundFailure extends CategoriesFailure {
  const CategoriesNotFoundFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.categoriesNotFoundFailure;
  }
}

class CategoriesReadCacheFailure extends CategoriesFailure {
  const CategoriesReadCacheFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.categoriesReadCacheFailure;
  }
}

class CategoriesCreateFailure extends CategoriesFailure {
  const CategoriesCreateFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.categoriesCreateFailure;
  }
}

class CategoriesUpdateFailure extends CategoriesFailure {
  const CategoriesUpdateFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.categoriesUpdateFailure;
  }
}

class CategoriesDeleteFailure extends CategoriesFailure {
  const CategoriesDeleteFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.categoriesDeleteFailure;
  }
}
