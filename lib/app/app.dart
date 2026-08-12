import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:smart_kitchen_flutter_app/app/router/app_router.dart";
import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";
import "package:smart_kitchen_flutter_app/core/theme/theme.dart";

class SmartKitchenApp extends StatelessWidget {
  final AppRouter _appRouter = getIt.get<AppRouter>();

  SmartKitchenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale("ru"),
      routerConfig: _appRouter.config(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      builder: FToastBuilder(),
    );
  }
}
