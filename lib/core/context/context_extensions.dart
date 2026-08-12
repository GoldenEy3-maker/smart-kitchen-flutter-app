import "package:flutter/material.dart";
import "package:smart_kitchen_flutter_app/core/l10n/app_localizations.dart";

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension AppLocalizationsGetter on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
