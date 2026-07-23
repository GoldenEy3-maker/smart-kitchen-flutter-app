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

  @override
  String get newCategory => 'Новая категория';

  @override
  String get cancel => 'Отмена';

  @override
  String get add => 'Добавить';

  @override
  String get emptyPlaceholderProductTitle => 'У вас пока нет продуктов';

  @override
  String get emptyPlaceholderProductDescription =>
      'Создайте свой первый продукт';

  @override
  String get emptyPlaceholderSearchTitle => 'Ничего не найдено';

  @override
  String get emptyPlaceholderSearchProductsDescription =>
      'Попробуйте другое название или создайте новый продукт';

  @override
  String get productFormAttention =>
      'Продукт попадёт в общий каталог. Количество и срок годности указываются при добавлении в холодильник.';
}
