import 'package:flutter/material.dart';

Widget buildSaveButton({required Function() save}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () => save(),
        child: const Text("Save Changes"),
      ),
    ),
  );
}
