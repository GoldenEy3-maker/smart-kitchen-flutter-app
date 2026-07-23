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
  String get productCatalogSearchHint => 'Найти продукты...';

  @override
  String productCatalogProductUnit(String unit) {
    return 'Единица измерения: $unit';
  }

  @override
  String get newProduct => 'Новый продукт';

  @override
  String get editProduct => 'Редактировать продукт';

  @override
  String get name => 'Название';

  @override
  String get enterName => 'Введите название';

  @override
  String get selectProductIcon => 'Выберите иконку продукта';

  @override
  String get select => 'Выбрать';

  @override
  String get category => 'Категория';

  @override
  String get createCategory => 'Создать категорию';
}
