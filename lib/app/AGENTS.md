# Слой сборки

Единственный слой, которому можно знать про всё остальное. Здесь склеиваются домены, фичи и инфраструктура: DI, роутинг, страницы, реализации навигаторов.

Логики здесь не бывает. Появилось желание что-то посчитать или преобразовать в `app` — значит это должно жить в use case или в bloc.

## Pages

`app/pages/<name>_page.dart` — точка входа роута и **только оркестрация зависимостей**:

- `@RoutePage()` над классом, `StatelessWidget`, имя заканчивается на `Page`.
- Достаёт зависимости из `getIt` — это единственное место (вместе с `di/`), где `getIt` вызывается напрямую.
- Создаёт `BlocProvider` и сразу добавляет начальное событие: `create: (_) => XBloc(...)..add(const XRequested())`.
- Прокидывает во view колбэки навигации (`(event) => router.maybePop(event)`).
- **Верстки в `Page` нет вообще, `Scaffold` здесь не создаётся** — он живёт во view фичи. `Page` отвечает на вопрос «из чего собран экран», view — «как он выглядит».

Эталон: `app/pages/product_form_page.dart`.

## Роутер

`app/router/app_router.dart` — `@AutoRouterConfig(replaceInRouteName: "Page,Route")`, то есть `ProductFormPage` превращается в `ProductFormRoute`. Табы вложены в `MainLayoutRoute`, модальные и полноэкранные формы объявлены на верхнем уровне.

Добавил `Page` — зарегистрируй роут в `routes` и запусти `dart run build_runner build --delete-conflicting-outputs`. Файл `app_router.gr.dart` сгенерирован, править его руками нельзя.

## DI

`app/di/di.dart` — единственная точка сборки, функция `registerAppDI()`. Первым всегда идёт `registerCoreScopeDI()` (Talker, Hive, роутер, ThemeProvider, навигаторы), дальше домены и фичи. Порядок внутри важен: зависимость должна быть зарегистрирована раньше того, кто её запрашивает, поэтому фича регистрируется после доменов, которые она использует.

- `core_scope.dart` — инфраструктура и то, что живёт всё время работы приложения.
- Регистрация домена — в `domains/<domain>/di`, регистрация фичи — в `features/<feature>/di`, `app/di/di.dart` только вызывает эти функции.
- Всё регистрируется через `registerLazySingleton`, кроме `AppRouter` (он `registerSingleton`, нужен сразу).
- Блоки в `getIt` **не** регистрируются: они создаются в `Page` через `BlocProvider` и живут по времени жизни экрана.

## Навигаторы

`app/navigation/<domain>_navigator_impl.dart` — реализация интерфейса `<Domain>Navigator` из домена. Единственное её содержимое — вызов роутера: `_router.push(XRoute(...))` с возвратом результата. Именно эта прослойка позволяет фичам не знать друг о друге и не видеть роутер.

Новый межэкранный переход: интерфейс и sealed-результат в `domains/<domain>/navigation`, реализация здесь, регистрация в `core_scope.dart`.

## Bootstrap и app

`main.dart` вызывает `bootstrap()`, который поднимает биндинги, DI, подключает `Bloc.observer` и `FlutterError.onError` к `Talker` и оборачивает всё в `runZonedGuarded`. Новый глобальный обработчик или инициализацию добавляй туда, а не в `main.dart`.

`app.dart` — `MaterialApp.router`: локаль жёстко `ru`, темы из `AppTheme`, `themeMode` слушается через `ThemeProvider`, тосты через `FToastBuilder()`.

## Layouts

`app/layouts/main_layout.dart` — `MainLayoutPage` с `AutoTabsScaffold` и нижней навигацией. Новый таб нужно добавить в трёх местах согласованно: в дети `MainLayoutRoute` в роутере, в список `routes` у `AutoTabsScaffold` и в `items` у `AppBottomNavigationBar`. **Порядок `routes` и `items` должен совпадать** — индекс таба берётся из него, и рассинхрон приводит к переходу не на тот экран.
