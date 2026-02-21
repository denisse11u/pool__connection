import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pool_connection/shared/widget/text_form_field.dart';

class AvatarTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? imageBase64;
  final File? imageFile;
  final VoidCallback onTap;
  const AvatarTextField({
    super.key,
    required this.controller,
    this.imageBase64,
    this.imageFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: imageFile != null
                  ? FileImage(imageFile!)
                  : (imageBase64 != null
                            ? MemoryImage(base64Decode(imageBase64!))
                            : null)
                        as ImageProvider<Object>?,
              child: imageFile == null && imageBase64 == null
                  ? const Icon(Icons.person, size: 30)
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormFieldWidget(
            controller: controller,
            labelText: 'Nombre',
            validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
            obscureText: false,
            decoration: const InputDecoration(),
          ),
        ),
      ],
    );
  }
}
