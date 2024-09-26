import 'package:flutter/material.dart';

void buildPickPhotoDialog(
  BuildContext context, {
  required Function() gallerySource,
  required Function() cameraSource,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog<String>(
      context: context,
      builder: (BuildContext c) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Update Profile Photo",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Select or capture a photo")),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      gallerySource();
                      Navigator.pop(c);
                    },
                    child: const Text("Gallery"),
                  ),
                  TextButton(
                    onPressed: () {
                      cameraSource();
                      Navigator.pop(c);
                    },
                    child: const Text("Camera"),
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
