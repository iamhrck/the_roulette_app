import 'package:flutter/material.dart';
import 'package:the_roulette_app/shared/constants/strings.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Strings.inputErrorDialogTitle),
      content: const Text(Strings.inputErrorDialogContent),
      actions: <Widget>[
        GestureDetector(
          child: const Text(Strings.inputErrorDialogButton),
          onTap: () => Navigator.pop(context),
        )
      ],
    );
  }
}
