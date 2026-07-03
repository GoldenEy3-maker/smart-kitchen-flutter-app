// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get helloWorld => 'Привет, мир!';

  @override
  String get productCatalogTitle => 'Каталог продуктов';

  @override
  String get productCatalogAllCategory => 'Все';

  @override
  String get productCatalogSearchHint => 'Поиск продукта...';

  @override
  String productCatalogTotalWithDescription(String total) {
    return '$total продуктов · общий справочник для холодильника и рецептов';
  }

  @override
  String productCatalogProductUnit(String unit) {
    return 'Ед. изм: $unit';
  }
}
