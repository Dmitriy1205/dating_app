import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectionMessage {
  ConnectionMessage._();

  static buildDisconnectedSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          AppLocalizations.of(context)!.checkConnection,
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static buildConnectedSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Connected',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static buildErrorSnackbar(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
