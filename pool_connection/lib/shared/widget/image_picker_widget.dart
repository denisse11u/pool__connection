import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? imageFile;
  final String? imageBase64;
  final VoidCallback onTap;
  final VoidCallback? onEditTap;
  const ImagePickerWidget({
    super.key,
    this.imageFile,
    this.imageBase64,
    required this.onTap,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = imageFile != null
        ? FileImage(imageFile!)
        : (imageBase64 != null ? MemoryImage(base64Decode(imageBase64!)) : null)
              as ImageProvider<Object>?;

    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: imageProvider,
            child: imageProvider == null
                ? const Icon(Icons.person, size: 40)
                : null,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onTap,
            child: const Icon(Icons.add_a_photo_rounded, size: 20),
          ),
        ),
      ],
    );
  }
}
