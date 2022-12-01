import 'dart:ui';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {
  static final localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    AppLocalizations.delegate,
  ];

  static final locales = [
    const Locale('en', ''),
    const Locale('es', ''),
    const Locale('fr', ''),
    const Locale('pt', ''),
  ];
}
