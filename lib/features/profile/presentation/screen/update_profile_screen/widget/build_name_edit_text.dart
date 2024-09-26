import 'package:flutter/material.dart';

Widget buildNameEditText(
  BuildContext context,
  TextEditingController nameTextFieldController,
  bool validateNameTextField,
) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextField(
      controller: nameTextFieldController,
      maxLines: 1,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        errorText: validateNameTextField ? "Enter your name" : null,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        labelText: "Name",
        prefixIcon: const Icon(Icons.lock),
        border: const UnderlineInputBorder(),
      ),
      textInputAction: TextInputAction.done,
      onSubmitted: (String val) {},
      onChanged: (String val) {},
    ),
  );
}
