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
  String get productsCatalogTitle => 'Каталог продуктов';

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

  @override
  String get selectOrCreate => 'Выберите или создайте';

  @override
  String productsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'продуктов',
      one: 'продукт',
      zero: 'продуктов',
    );
    return '$count $_temp0';
  }

  @override
  String get selectCategory => 'Выберите категорию';

  @override
  String get deleteCategory => 'Удаление категории';

  @override
  String get deleteCategoryDescription =>
      'Вы уверены, что хотите удалить категорию?';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteCategoryWithProductsBoundedDescription =>
      'Удаление категории с привязанными продуктами невозможно. Сначала отвяжите все продукты от этой категории.';

  @override
  String get editCategory => 'Редактировать категорию';

  @override
  String get edit => 'Редактировать';

  @override
  String get unitLabel => 'Единица измерения';

  @override
  String get save => 'Сохранить';

  @override
  String get selectUnit => 'Выберите единицу измерения';

  @override
  String get unit_fullPiece => 'Штук';

  @override
  String get unit_fullGram => 'Граммы';

  @override
  String get unit_fullMilliliter => 'Миллилитры';

  @override
  String get unit_shortPiece => 'шт.';

  @override
  String get unit_shortGram => 'г.';

  @override
  String get unit_shortMilliliter => 'мл.';

  @override
  String get unit_fullKilogram => 'Килограммы';

  @override
  String get unit_shortKilogram => 'кг.';

  @override
  String get unit_fullLiter => 'Литры';

  @override
  String get unit_shortLiter => 'л.';

  @override
  String get cacheFailure =>
      'Ошибка чтения/записи кэша. Попробуйте перезапустить приложение и попробовать снова.';

  @override
  String get unknownFailure =>
      'Произошла неизвестная ошибка. Попробуйте позже.';

  @override
  String get categoriesNotFoundFailure => 'Категория не найдена.';

  @override
  String get categoriesReadCacheFailure =>
      'Ошибка чтения кэша категорий. Попробуйте перезапустить приложение и попробовать снова.';

  @override
  String get categoriesCreateFailure =>
      'Ошибка создания категории. Попробуйте позже.';

  @override
  String get categoriesUpdateFailure =>
      'Ошибка обновления категории. Попробуйте позже.';

  @override
  String get categoriesDeleteFailure =>
      'Ошибка удаления категории. Попробуйте позже.';

  @override
  String get productsReadCacheFailure =>
      'Ошибка чтения кэша продуктов. Попробуйте перезапустить приложение и попробовать снова.';

  @override
  String get productsCreateCacheFailure =>
      'Ошибка создания кэша продуктов. Попробуйте перезапустить приложение и попробовать снова.';

  @override
  String get productsUpdateCacheFailure =>
      'Ошибка обновления кэша продуктов. Попробуйте перезапустить приложение и попробовать снова.';

  @override
  String get productsNotFoundFailure => 'Продукт не найден.';

  @override
  String get productsDeleteCacheFailure =>
      'Ошибка удаления кэша продуктов. Попробуйте перезапустить приложение и попробовать снова.';

  @override
  String get iconIsRequired => 'Иконка обязательна';

  @override
  String get categoryIsRequired => 'Категория обязательна';

  @override
  String get unitIsRequired => 'Единица измерения обязательна';

  @override
  String get nameIsRequired => 'Название обязательно';

  @override
  String get productConfirmDeleteSheetTitle => 'Удаление продукта';

  @override
  String get productConfirmDeleteSheetDescription =>
      'Вы уверены, что хотите удалить этот продукт?';

  @override
  String get error => 'Произошла ошибка';

  @override
  String get tryAgain => 'Попробовать снова';
}
