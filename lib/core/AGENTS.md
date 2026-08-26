# Core

Инфраструктура и дизайн-система. `core` не знает ни про `domains`, ни про `features` — сюда нельзя складывать доменную логику и знание о конкретных экранах. Если сущность относится к предметной области, её место в `lib/domains`; если нужна только одному экрану — в `presentation/widgets` этой фичи. В `core` попадает то, чем пользуются минимум две фичи и что не завязано на предметную область.

## Тема и токены

Токены — статические константы в `core/theme`: `AppSpacing` (ритм 4/8), `AppRadius`, `AppDuration`, `AppFonts`. Цвета и типографика — не константы, а `ThemeExtension`: `AppColorsExtension` и `AppTextExtension` регистрируются в `ThemeData.extensions` внутри `AppTheme._buildThemeData` и достаются через `context.theme.colors` и `context.theme.text` (расширение `AppThemeExtension on ThemeData` в `app_theme.dart`).

- Новый цвет — поле в `AppColorsExtension`, обязательно в обоих наборах `light` и `dark`, плюс в `copyWith` и `lerp`.
- Новый стиль текста — поле в `AppTextExtension`, там же в `copyWith` и `lerp`.
- Новый размер отступа или радиуса — константа в соответствующем классе токенов, а не число в месте использования.
- Тёмная тема пока не в продукте, но `AppColorsExtension.dark` поддерживается — не оставляй его без нового цвета.

Оформление стандартных Material-компонентов настраивается централизованно в `AppTheme` (`inputDecorationTheme`, `chipTheme`, `appBarTheme`, `bottomSheetTheme`, ...). Если нужно, чтобы все инпуты или чипы выглядели иначе, правь тему, а не каждое место использования.

## Виджеты

`core/widgets` — переиспользуемые части дизайн-системы. Конвенции:

- `const` конструктор, `super.key`, поля `final`.
- Все размеры, цвета, радиусы и длительности берутся из токенов и `context.theme`, хардкода в виджете нет.
- Варианты внешнего вида — не булевы флаги, а отдельные типы рядом с виджетом: `ButtonStyle`, `ButtonSize`, `ButtonRounder`, `AppInputShape`, `AppInputStyle`. Новый вариант — новое значение в этом типе, а не `if` внутри виджета.
- Виджет не знает про BLoC и не ходит в `getIt` — только входные параметры и колбэки.

## Контекст

Расширения `BuildContext` живут в `core/context`: `context.theme` вместо `Theme.of(context)` и `context.l10n` вместо `AppLocalizations.of(context)!`. Используй их, а не оригинальные вызовы.

## Локализация

Интерфейс только на русском. Единственный источник строк — `core/l10n/app_ru.arb`, обращение через `context.l10n.<key>`. После добавления ключа запусти `flutter gen-l10n`. Файлы `app_localizations.dart` и `app_localizations_ru.dart` сгенерированы — руками их не трогай.

Каждый новый `Failure` обязан иметь ключ сообщения: без него `localizedMessage` не скомпилируется.

## Ошибки

`core/error/failure.dart` — базовый `abstract class Failure` с `localizedMessage(AppLocalizations l10n)` и общие `CacheFailure` / `UnknownFailure`. Доменные ошибки наследуются от `Failure` внутри своего домена, в `core` их складывать не надо.

## Either

`core/utils/either.dart` — тонкая обёртка над `dartz`: `typedef Either<L, R>`, функции-хелперы `Left`/`Right` (позволяют не писать типовые аргументы явно) и расширения `isLeft`, `isRight`, `rightOrNull`, `leftOrNull`. Импортируй `Either` только отсюда, а не из `dartz` напрямую — так замена библиотеки останется точечной.

## Каталоги значений

`core/icons/catalog_icons.dart` и `core/units/catalog_units.dart` — enum'ы со связанными данными и статическим `fromName(String?)`, возвращающим `fallback` при неизвестном значении.

**Важно:** в Hive хранится результат `.name` (`Product.iconKey`, `Product.unit` — это `String`). Переименование или удаление значения enum ломает уже сохранённые у пользователя данные и молча превращает их в `fallback`. Добавлять новые значения можно свободно, переименовывать существующие — нельзя.

## Storage и логирование

`HiveInitializer` инициализирует Hive в `bootstrap` и возвращает путь хранилища. Открытием конкретных боксов занимаются data sources в доменах, `core` про боксы не знает.

Логирование — только через `Talker` из `getIt`. `print` и `debugPrint` в коде не используются. `Bloc.observer` и `FlutterError.onError` уже подключены к `Talker` в `app/bootstrap.dart`.
