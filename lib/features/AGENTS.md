# Слой фич

Фича — это экран или пользовательский сценарий: своё состояние, свой UI. Эталон — `product_form` (форма с несколькими операциями) и `products_catalog` (список с поиском и фильтрами).

Фича **не импортирует другую фичу**. Нужен переход на другой экран — только через интерфейс `<Domain>Navigator` из `domains/<domain>/navigation`, который приходит в конструктор снаружи.

## Структура фичи

```
features/<feature>/
  domain/entities/       — view-модели фичи (опционально)
  domain/usecases/       — композиция нескольких доменов (опционально)
  presentation/bloc/     — bloc + part-файлы event и state
  presentation/views/    — экран целиком, включая Scaffold
  presentation/widgets/  — приватные виджеты этого экрана
  di/                    — регистрация use cases фичи (если они есть)
```

`domain/` у фичи появляется только когда нужно собрать данные из нескольких доменов или подготовить view-модель. Простая фича состоит из одного `presentation/`.

Сущности фичи (`CategoryWithProducts`, `FridgeProductItem`) — это composition над доменными entity: они складывают вместе данные из разных доменов, не пытаясь подменить собой домен. Такая же immutable-сущность на `Equatable`, с `loading`-заготовкой для скелетонов.

## BLoC

Три файла: `<feature>_bloc.dart` плюс `part "<feature>_event.dart"` и `part "<feature>_state.dart"`. Барель `bloc.dart` экспортирует только сам bloc — событий и состояния снаружи через барель не видно, они приезжают вместе с `part`.

**События** — `sealed class <Feature>Event extends Equatable` с `props => []` в базовом классе. Наследники называются по факту произошедшего, в прошедшем времени: `...Requested` для запуска операции, `...Selected` для выбора, `...Changed` для изменения ввода. Имя события начинается с имени фичи (`ProductFormCategoriesRequested`) — так читается, к какому блоку оно относится, когда в файле их десяток. Часть старых блоков этого префикса не имеет; переименовывать их без отдельной просьбы не надо, но новые события пиши с префиксом.

**Состояние** — один класс `extends Equatable`, никаких sealed-иерархий состояний. Внутри:

- Флаги — отдельный `bool` на каждую операцию (`isCategoriesLoading`, `isSaveProductPending`, `isDeleteCategoryPending`), а не один общий `isLoading`. Экран может грузить и сохранять одновременно, и UI должен различать эти состояния.
- Ошибка — `Failure? error`. UI показывает её через `error.localizedMessage(context.l10n)`. Bloc не превращает Failure в строку.
- `copyWith`, где nullable-поля, которые нужно уметь сбрасывать, объявлены как `ValueGetter<T?>?`. Семантика: не передали параметр — значение сохраняется; передали `() => null` — значение затирается в `null`; передали `() => x` — ставится `x`. Без этого приёма невозможно отличить «не менять» от «сбросить». Не «упрощай» это до обычного nullable-параметра.
- `props` перечисляет все поля состояния.

**Обработчики** — приватные методы `_on<EventName>(event, emit)`, зарегистрированные в конструкторе через `on<Event>(_onHandler)` в том же порядке, в котором объявлены события. Типовой обработчик асинхронной операции:

```dart
emit(state.copyWith(isXPending: true, error: () => null));
final result = await _useCase(params);
result.fold(
  (failure) => emit(state.copyWith(isXPending: false, error: () => failure)),
  (value) => emit(state.copyWith(isXPending: false, error: () => null, /* ... */)),
);
```

Зависимости bloc — только use cases, приватными полями через `required this._useCase`. Репозитории в bloc не приходят. Начальное состояние собирается в `super(...)` в конструкторе, начальное событие добавляет `Page` при создании блока.

## Views

`presentation/views/<name>_view.dart` — весь UI экрана, включая корневой `Scaffold` со всем содержимым (`appBar`, `body`, `floatingActionButton`). `Page` из `lib/app/pages` отвечает только за сборку зависимостей и верстки не содержит: `Page` — «из чего собран экран», `View` — «как он выглядит».

- **`getIt` внутри `features` использовать нельзя.** Всё, что нужно view — навигаторы, колбэки — приходит через конструктор от `Page`.
- Состояние читается через `BlocBuilder`, события отправляются через `context.read<XBloc>().add(...)`.
- Локальные константы верстки (высоты хедеров, отступы между блоками) — в приватный `final class _<Name>ViewConfig` с приватным конструктором и статическими полями. Эталон: `features/products_catalog/presentation/views/products_catalog_view.dart`.
- Загрузка показывается через `Skeletonizer` вокруг реального лейаута с `loading`-заготовками entity, а не спиннером: список рисуется из трёх `Entity.loading` с `Skeletonizer(enabled: state.isLoading)`.
- Пустое состояние — `EmptyPlaceholder`, ошибка — `ErrorPlaceholder` с колбэком повтора. Оба из `core/widgets`.
- Разбор sealed-результата навигации — через исчерпывающий `switch` по всем вариантам, без `default`.

`presentation/widgets/` — куски этого экрана, вынесенные для читаемости (`ProductTile`, `CreateProductButton`, листы-шторки). Если виджет пригодился второй фиче, ему место в `core/widgets`, а не в импорте из соседней фичи.

## Чек-лист новой фичи

1. `presentation/bloc/` — три файла плюс барель `bloc.dart`.
2. `presentation/views/` — view со своим `Scaffold`, барель `views.dart`.
3. Свои use cases в `domain/usecases` и `register<Feature>DI()`, только если нужна композиция доменов.
4. `Page` в `lib/app/pages` с `@RoutePage()`, регистрация роута в `app/router/app_router.dart`, затем `build_runner`.
5. `flutter analyze` и `dart format .`.
