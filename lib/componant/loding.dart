import 'package:flutter/material.dart';

class Loading {
  start(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  stopDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }
}
