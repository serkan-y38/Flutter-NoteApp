import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildUpdatePhotoRow(
  BuildContext context, {
  required File? selectedImg,
  required String url,
  required Function() onClick,
}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: InkWell(
      onTap: () => onClick(),
      child: Row(
        children: [
          _buildCircularImage(context, url, selectedImg),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("Update profile photo"),
          )
        ],
      ),
    ),
  );
}

Widget _buildCircularImage(
  BuildContext context,
  String url,
  File? selectedImg,
) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
          width: 1, color: Theme.of(context).colorScheme.onSurfaceVariant),
    ),
    child: ClipOval(
      child: (selectedImg != null)
          ? Image.file(
              selectedImg,
              width: 96,
              height: 96,
              fit: BoxFit.cover,
            )
          : (url.isNotEmpty)
              ? CachedNetworkImage(
                  width: 96,
                  height: 96,
                  imageUrl: url,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Theme.of(context).colorScheme.primary,
                    strokeWidth: 4,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : const Icon(
                  Icons.person,
                  size: 96,
                ),
    ),
  );
}
