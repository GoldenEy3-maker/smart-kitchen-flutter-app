import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";

sealed class ProductsFailure extends Failure {
  const ProductsFailure();
}

class ProductsReadCacheFailure extends ProductsFailure {
  const ProductsReadCacheFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.productsReadCacheFailure;
  }
}

class ProductsCreateCacheFailure extends ProductsFailure {
  const ProductsCreateCacheFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.productsCreateCacheFailure;
  }
}

class ProductsUpdateCacheFailure extends ProductsFailure {
  const ProductsUpdateCacheFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.productsUpdateCacheFailure;
  }
}

class ProductsNotFoundFailure extends ProductsFailure {
  const ProductsNotFoundFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.productsNotFoundFailure;
  }
}

class ProductsDeleteCacheFailure extends ProductsFailure {
  const ProductsDeleteCacheFailure();

  @override
  String localizedMessage(AppLocalizations l10n) {
    return l10n.productsDeleteCacheFailure;
  }
}
