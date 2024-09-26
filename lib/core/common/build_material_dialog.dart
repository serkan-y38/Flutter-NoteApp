import 'package:flutter/material.dart';

void buildMaterialDialog(
  BuildContext context, {
  required String title,
  required String text,
  required String actionText,
  required bool dismissible,
  required Function() action,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog<String>(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext c) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(text)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){
                      action();
                      Navigator.pop(c);
                    },
                    child: Text(actionText),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
}
