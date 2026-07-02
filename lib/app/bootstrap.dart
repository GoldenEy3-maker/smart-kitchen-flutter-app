import "dart:async";

import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/app/app.dart";
import "package:smart_kitchen_flutter_app/app/di/di.dart";
import "package:smart_kitchen_flutter_app/core/di/di.dart";
import "package:talker_flutter/talker_flutter.dart";

Future<void> bootstrap() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await registerAppDI();

    FlutterError.onError = (details) => getIt.get<Talker>().error(
      "FlutterError",
      details.exception,
      details.stack,
    );

    runApp(SmartKitchenApp());
  }, (e, st) => getIt.get<Talker>().error(e, st));
}
