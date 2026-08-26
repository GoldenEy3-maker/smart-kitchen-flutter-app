# Доменный слой

Предметные области приложения. Слой не знает ничего про UI, `features` и `app` — только про себя, соседние домены и `core`.

Эталон для любого нового домена — `products`. Он полный: все четыре CRUD-операции, навигация, DI.

## Структура домена

```
domains/<domain>/
  domain/entities/       — сущности предметной области
  domain/repositories/   — интерфейсы репозиториев
  domain/usecases/       — по одному use case на операцию
  data/models/           — DTO для Hive с json_serializable
  data/data_sources/     — интерфейс + Impl, работа с Hive
  data/repositories/     — реализации интерфейсов из domain
  params/                — параметры операций
  error/                 — sealed-иерархия Failure домена
  navigation/            — интерфейсы навигации (реализация в app/navigation)
  di/                    — регистрация в getIt
```

В каждой папке барель-файл, который экспортирует её содержимое.

## Конвенции

**Entity** (`domain/entities`) — immutable, `extends Equatable`, все поля `final`, конструктор `const` с named-параметрами. Для скелетонов загрузки — именованный конструктор `Entity.loading()` с заглушками, а не статический геттер (`prefer_constructors_over_static_methods`). Entity не знает про JSON и Hive.

**Model** (`data/models`) — `@JsonSerializable()`, `part "<name>_model.g.dart"`, метод `toEntity()`. Модель — это формат хранения, она **не выходит за пределы `data`**: наружу репозиторий отдаёт только entity. После правки модели запусти `build_runner`.

**Params** (`params/`) — простой immutable-класс на каждую операцию, без Equatable. В `Create*Params` поля обязательные, в `Update*Params` — nullable, где `null` означает «не менять это поле». В `Delete*Params` обычно только `id`.

**Data source** (`data/data_sources`) — `abstract interface class <Domain>LocalDataSource` плюс `class <Domain>LocalDataSourceImpl`. Правила:

- Возвращает `Future<Either<Failure, Model>>` и **никогда не бросает исключения наружу**: весь доступ к Hive внутри `try/catch`.
- В `catch` логирует через `Talker` (`_talker.error("<operation> failed", e, st)`) и возвращает `Left(<Domain><Op>CacheFailure())`.
- Ожидаемые частные случаи ловятся отдельным `on`-блоком перед общим: `on StateError` при ненайденной записи → `Left(<Domain>NotFoundFailure())`.
- Имена Hive-боксов — через `enum <Domain>LocalDataSourceBoxName`, строковых литералов быть не должно.
- Открытие бокса — через приватный хелпер с проверкой `Hive.isBoxOpen`.

**Repository** — интерфейс в `domain/repositories`, реализация в `data/repositories`. Реализация делегирует в data source и мапит модель в entity: `result.fold(Left, (m) => Right(m.toEntity()))`. Своей логики и своих `try/catch` в репозитории нет.

**UseCase** (`domain/usecases`) — один класс на операцию, `implements UseCase<ResultType, Params>` из `core/usecase`. Зависимости — приватные поля через `required this._repository`. Тонкие делегаты в одну строку это норма: они держат стабильную границу для presentation и дают место для валидации и побочных эффектов, когда те понадобятся. Операция без параметров принимает `NoParams`.

**Failure** (`error/`) — `sealed class <Domain>Failure extends Failure`, наследники на каждый сценарий отказа переопределяют `localizedMessage(AppLocalizations l10n)`. Каждый новый Failure требует ключа в `app_ru.arb` — без него он не соберётся.

**DI** (`di/`) — функция `register<Domain>DI()`, всё через `registerLazySingleton` в порядке data source → repository → use cases. Функция вызывается из `app/di/di.dart`.

**Navigation** (`navigation/`) — только `abstract interface class <Domain>Navigator` с методами вида `Future<Result?> open<Screen>(...)`. Здесь же sealed-классы результата (`Open*ResultEvent`). Реализация живёт в `app/navigation` и знает про роутер, домен про роутер не знает.

## Cross-импорты между доменами

`domains` — единственный слой, где импорт соседа у соседа разрешён. Это осознанное решение, а не недосмотр.

Предметные области в реальности пересекаются: продукта без категории в этом приложении не существует. Если запретить домену знать о соседе, остаются только плохие варианты — дублировать `Category` внутри `products` и получить два источника правды на одну сущность, поднять её в `core` и превратить инфраструктурный слой в свалку доменной логики, или разорвать связь на уровне сигнатур, заставив каждый вызывающий слой вручную склеивать то, что по смыслу связано неразрывно. `domains` вынесен в отдельный слой именно для того, чтобы связность внутри доменной логики было где выразить, не ломая при этом изоляцию фич.

При этом cross-импорт — не способ по умолчанию, а последнее средство:

- По умолчанию сущность ссылается на чужую по идентификатору, а не встраивает её: `Product.categoryId` — это `String`, а не `Category`.
- Композицию нескольких доменов делай **выше**, в use case фичи. Эталон: `features/fridge_catalog/domain/usecases/get_fridge_catalog_items.dart` — тянет `GetFridgeProducts` и `GetProducts` и собирает `FridgeProductItem` уже на уровне фичи, оставляя оба домена независимыми.
- Cross-импорт оправдан, когда связь принадлежит самому домену и без неё его контракт неполон. Живой пример — `domains/products/navigation/open_product_form_result_event.dart`: результат работы формы продукта включает список категорий, потому что форма умеет их менять, и разрывать это на два несвязанных результата бессмысленно.
- Циклы запрещены: если `A` импортирует `B`, то `B` не импортирует `A`. Возник цикл — значит связь должна была уехать в фичу.
- Импортировать у соседнего домена можно только `domain` (entities, repositories, usecases) и `params`. Его `data` — models и data sources — никогда.

Прежде чем добавить новый cross-импорт, проверь, не решается ли задача композицией в use case фичи. Если решается — делай так.

## Чек-лист нового домена

1. Разложить папки по структуре выше, в каждой — барель.
2. Entity → Model с `toEntity()` → Params → интерфейс data source → Impl → интерфейс репозитория → Impl → use cases.
3. Sealed-иерархия Failure плюс ключи в `app_ru.arb`.
4. `register<Domain>DI()` и вызов из `app/di/di.dart`.
5. `dart run build_runner build --delete-conflicting-outputs`, затем `flutter analyze` и `dart format .`.
