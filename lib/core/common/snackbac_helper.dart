import 'package:flutter/material.dart';

void showSnackBarWithAction(
    BuildContext context, String text, String actionText,
    {required Function(void) onActionPressed}) {
  final s = SnackBar(
    content: Text(text),
    action: SnackBarAction(label: actionText, onPressed: () => onActionPressed),
  );
  ScaffoldMessenger.of(context).showSnackBar(s);
}

void showBasicSnackBar(BuildContext context, String text) {
  final s = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(s);
}
