import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// The conventional newborn programmer greeting
  ///
  /// In ru, this message translates to:
  /// **'Привет, мир!'**
  String get helloWorld;

  /// Заголовок страницы каталога продуктов
  ///
  /// In ru, this message translates to:
  /// **'Каталог продуктов'**
  String get productsCatalogTitle;

  /// Название категории всех продуктов
  ///
  /// In ru, this message translates to:
  /// **'Все'**
  String get productCatalogAllCategory;

  /// Подсказка для поиска продукта
  ///
  /// In ru, this message translates to:
  /// **'Найти продукты...'**
  String get productCatalogSearchHint;

  /// Текст с единицей измерения продукта
  ///
  /// In ru, this message translates to:
  /// **'Единица измерения: {unit}'**
  String productCatalogProductUnit(String unit);

  /// Название страницы для добавления нового продукта
  ///
  /// In ru, this message translates to:
  /// **'Новый продукт'**
  String get newProduct;

  /// Название страницы для редактирования продукта
  ///
  /// In ru, this message translates to:
  /// **'Редактировать продукт'**
  String get editProduct;

  /// Название поля для ввода имени
  ///
  /// In ru, this message translates to:
  /// **'Название'**
  String get name;

  /// Подсказка для ввода названия
  ///
  /// In ru, this message translates to:
  /// **'Введите название'**
  String get enterName;

  /// Заголовок для выбора иконки продукта
  ///
  /// In ru, this message translates to:
  /// **'Выберите иконку продукта'**
  String get selectProductIcon;

  /// Текст для кнопки выбора
  ///
  /// In ru, this message translates to:
  /// **'Выбрать'**
  String get select;

  /// Название поля для выбора категории
  ///
  /// In ru, this message translates to:
  /// **'Категория'**
  String get category;

  /// Название кнопки для создания категории
  ///
  /// In ru, this message translates to:
  /// **'Создать категорию'**
  String get createCategory;

  /// Название страницы для создания новой категории
  ///
  /// In ru, this message translates to:
  /// **'Новая категория'**
  String get newCategory;

  /// Название кнопки для отмены
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// Название кнопки для добавления
  ///
  /// In ru, this message translates to:
  /// **'Добавить'**
  String get add;

  /// Заголовок пустого места для продуктов
  ///
  /// In ru, this message translates to:
  /// **'У вас пока нет продуктов'**
  String get emptyPlaceholderProductTitle;

  /// Описание пустого места для продуктов
  ///
  /// In ru, this message translates to:
  /// **'Создайте свой первый продукт'**
  String get emptyPlaceholderProductDescription;

  /// Заголовок пустого места для поиска
  ///
  /// In ru, this message translates to:
  /// **'Ничего не найдено'**
  String get emptyPlaceholderSearchTitle;

  /// Описание пустого места для поиска продуктов
  ///
  /// In ru, this message translates to:
  /// **'Попробуйте другое название или создайте новый продукт'**
  String get emptyPlaceholderSearchProductsDescription;

  /// Текст с вниманием для формы добавления продукта
  ///
  /// In ru, this message translates to:
  /// **'Продукт попадёт в общий каталог. Количество и срок годности указываются при добавлении в холодильник.'**
  String get productFormAttention;

  /// Текст для выбора или создания чего-либо
  ///
  /// In ru, this message translates to:
  /// **'Выберите или создайте'**
  String get selectOrCreate;

  /// Текст с количеством продуктов
  ///
  /// In ru, this message translates to:
  /// **'{count} {count, plural, zero {продуктов} one {продукт} other {продуктов}}'**
  String productsCount(int count);

  /// Заголовок для выбора категории
  ///
  /// In ru, this message translates to:
  /// **'Выберите категорию'**
  String get selectCategory;

  /// Заголовок для удаления категории
  ///
  /// In ru, this message translates to:
  /// **'Удаление категории'**
  String get deleteCategory;

  /// Описание для удаления категории
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить категорию?'**
  String get deleteCategoryDescription;

  /// Название кнопки для удаления
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// Описание для удаления категории с привязанными продуктами
  ///
  /// In ru, this message translates to:
  /// **'Удаление категории с привязанными продуктами невозможно. Сначала отвяжите все продукты от этой категории.'**
  String get deleteCategoryWithProductsBoundedDescription;

  /// Название страницы для редактирования категории
  ///
  /// In ru, this message translates to:
  /// **'Редактировать категорию'**
  String get editCategory;

  /// Название кнопки для редактирования
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get edit;

  /// Название поля для ввода единицы измерения
  ///
  /// In ru, this message translates to:
  /// **'Единица измерения'**
  String get unitLabel;

  /// Название кнопки для сохранения
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// Заголовок для выбора единицы измерения
  ///
  /// In ru, this message translates to:
  /// **'Выберите единицу измерения'**
  String get selectUnit;

  /// Полное название единицы измерения: Штук
  ///
  /// In ru, this message translates to:
  /// **'Штук'**
  String get unit_fullPiece;

  /// Полное название единицы измерения: Граммы
  ///
  /// In ru, this message translates to:
  /// **'Граммы'**
  String get unit_fullGram;

  /// Полное название единицы измерения: Миллилитры
  ///
  /// In ru, this message translates to:
  /// **'Миллилитры'**
  String get unit_fullMilliliter;

  /// Короткое название единицы измерения: Штук
  ///
  /// In ru, this message translates to:
  /// **'шт.'**
  String get unit_shortPiece;

  /// Короткое название единицы измерения: Граммы
  ///
  /// In ru, this message translates to:
  /// **'г.'**
  String get unit_shortGram;

  /// Короткое название единицы измерения: Миллилитры
  ///
  /// In ru, this message translates to:
  /// **'мл.'**
  String get unit_shortMilliliter;

  /// Полное название единицы измерения: Килограммы
  ///
  /// In ru, this message translates to:
  /// **'Килограммы'**
  String get unit_fullKilogram;

  /// Короткое название единицы измерения: Килограммы
  ///
  /// In ru, this message translates to:
  /// **'кг.'**
  String get unit_shortKilogram;

  /// Полное название единицы измерения: Литры
  ///
  /// In ru, this message translates to:
  /// **'Литры'**
  String get unit_fullLiter;

  /// Короткое название единицы измерения: Литры
  ///
  /// In ru, this message translates to:
  /// **'л.'**
  String get unit_shortLiter;

  /// Ошибка чтения/записи кэша
  ///
  /// In ru, this message translates to:
  /// **'Ошибка чтения/записи кэша. Попробуйте перезапустить приложение и попробовать снова.'**
  String get cacheFailure;

  /// Ошибка неизвестная ошибка
  ///
  /// In ru, this message translates to:
  /// **'Произошла неизвестная ошибка. Попробуйте позже.'**
  String get unknownFailure;

  /// Ошибка категории не найденной
  ///
  /// In ru, this message translates to:
  /// **'Категория не найдена.'**
  String get categoriesNotFoundFailure;

  /// Ошибка чтения кэша категорий
  ///
  /// In ru, this message translates to:
  /// **'Ошибка чтения кэша категорий. Попробуйте перезапустить приложение и попробовать снова.'**
  String get categoriesReadCacheFailure;

  /// Ошибка создания категории
  ///
  /// In ru, this message translates to:
  /// **'Ошибка создания категории. Попробуйте позже.'**
  String get categoriesCreateFailure;

  /// Ошибка обновления категории
  ///
  /// In ru, this message translates to:
  /// **'Ошибка обновления категории. Попробуйте позже.'**
  String get categoriesUpdateFailure;

  /// Ошибка удаления категории
  ///
  /// In ru, this message translates to:
  /// **'Ошибка удаления категории. Попробуйте позже.'**
  String get categoriesDeleteFailure;

  /// Ошибка чтения кэша продуктов
  ///
  /// In ru, this message translates to:
  /// **'Ошибка чтения кэша продуктов. Попробуйте перезапустить приложение и попробовать снова.'**
  String get productsReadCacheFailure;

  /// Ошибка создания кэша продуктов
  ///
  /// In ru, this message translates to:
  /// **'Ошибка создания кэша продуктов. Попробуйте перезапустить приложение и попробовать снова.'**
  String get productsCreateCacheFailure;

  /// Ошибка обновления кэша продуктов
  ///
  /// In ru, this message translates to:
  /// **'Ошибка обновления кэша продуктов. Попробуйте перезапустить приложение и попробовать снова.'**
  String get productsUpdateCacheFailure;

  /// Ошибка продукта не найденного
  ///
  /// In ru, this message translates to:
  /// **'Продукт не найден.'**
  String get productsNotFoundFailure;

  /// Ошибка удаления кэша продуктов
  ///
  /// In ru, this message translates to:
  /// **'Ошибка удаления кэша продуктов. Попробуйте перезапустить приложение и попробовать снова.'**
  String get productsDeleteCacheFailure;

  /// Ошибка иконки обязательной
  ///
  /// In ru, this message translates to:
  /// **'Иконка обязательна'**
  String get iconIsRequired;

  /// Ошибка категории обязательной
  ///
  /// In ru, this message translates to:
  /// **'Категория обязательна'**
  String get categoryIsRequired;

  /// Ошибка единицы измерения обязательной
  ///
  /// In ru, this message translates to:
  /// **'Единица измерения обязательна'**
  String get unitIsRequired;

  /// Ошибка названия обязательной
  ///
  /// In ru, this message translates to:
  /// **'Название обязательно'**
  String get nameIsRequired;

  /// Заголовок для удаления продукта
  ///
  /// In ru, this message translates to:
  /// **'Удаление продукта'**
  String get productConfirmDeleteSheetTitle;

  /// Описание для удаления продукта
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить этот продукт?'**
  String get productConfirmDeleteSheetDescription;

  /// Заголовок ошибки
  ///
  /// In ru, this message translates to:
  /// **'Произошла ошибка'**
  String get error;

  /// Название кнопки для повторного действия
  ///
  /// In ru, this message translates to:
  /// **'Попробовать снова'**
  String get tryAgain;

  /// Название страницы для холодильника
  ///
  /// In ru, this message translates to:
  /// **'Холодильник'**
  String get fridge;

  /// Название страницы для рецептов
  ///
  /// In ru, this message translates to:
  /// **'Рецепты'**
  String get recipes;

  /// Название страницы для меню
  ///
  /// In ru, this message translates to:
  /// **'Меню'**
  String get menu;

  /// Название страницы для корзины
  ///
  /// In ru, this message translates to:
  /// **'Корзина'**
  String get basket;

  /// Название кнопки для добавления продукта в холодильник
  ///
  /// In ru, this message translates to:
  /// **'В холодильник'**
  String get addFridgeProduct;

  /// Заголовок страницы для добавления продукта в холодильник
  ///
  /// In ru, this message translates to:
  /// **'Добавить в холодильник'**
  String get fridgeFormPageAppBarTitle;

  /// Ошибка чтения кэша продуктов холодильника
  ///
  /// In ru, this message translates to:
  /// **'Ошибка чтения кэша продуктов холодильника. Попробуйте перезапустить приложение и попробовать снова.'**
  String get fridgeReadProductsCacheFailure;

  /// Ошибка продукта не найденного в холодильнике
  ///
  /// In ru, this message translates to:
  /// **'Продукт не найден в холодильнике.'**
  String get fridgeProductNotFoundFailure;

  /// Заголовок пустого места для продуктов в холодильнике
  ///
  /// In ru, this message translates to:
  /// **'У вас пока нет продуктов в холодильнике'**
  String get emptyPlaceholderFridgeProductsTitle;

  /// Описание пустого места для продуктов в холодильнике
  ///
  /// In ru, this message translates to:
  /// **'Добавьте продукты в холодильник из каталога продуктов'**
  String get emptyPlaceholderFridgeProductsDescription;

  /// Подсказка для поиска продуктов
  ///
  /// In ru, this message translates to:
  /// **'Найти продукты...'**
  String get findProductsHint;

  /// Название страницы для каталога
  ///
  /// In ru, this message translates to:
  /// **'Каталог'**
  String get catalog;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
