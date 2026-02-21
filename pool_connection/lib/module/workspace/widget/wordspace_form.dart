import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pool_connection/models/wordspace_model.dart';
import 'package:pool_connection/module/home/page/home_page.dart';
import 'package:pool_connection/shared/storage/wordspace_storage.dart';
import 'package:pool_connection/shared/widget/image_picker_widget.dart';

class WordspaceForm extends StatefulWidget {
  final WordspaceModel? wordspace;
  const WordspaceForm({super.key, this.wordspace});

  @override
  State<WordspaceForm> createState() => _WordspaceFormState();
}

class _WordspaceFormState extends State<WordspaceForm> {
  late final TextEditingController nameController;
  File? selectedImage;
  final _formKey = GlobalKey<FormState>();
  final _storage = WordspaceStorage();
  bool isediting = false;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.wordspace?.name ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    if (!isediting) return;
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => selectedImage = File(picked.path));
  }

  WordspaceModel createWordspaceObject() {
    final image = selectedImage != null
        ? base64Encode(selectedImage!.readAsBytesSync())
        : widget.wordspace?.imageBase64;

    return WordspaceModel(
      id: widget.wordspace?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: nameController.text.trim(),
      description: '',
      credentials: widget.wordspace?.credentials ?? [],
      imageBase64: image,
    );
  }

  Future<void> _saveWordspace() async {
    final wordspace = createWordspaceObject();
    if (widget.wordspace == null) {
      await _storage.addWordspace(wordspace);
    } else {
      await _storage.updateWordspace(wordspace);
      setState(() => isediting = false);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.wordspace == null ? 'Crear Espacio' : widget.wordspace!.name,
        ),
        actions: [
          if (!isediting && widget.wordspace != null)
            IconButton(
              onPressed: () => setState(() => isediting = true),
              icon: Icon(Icons.edit),
            ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  HomePage(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ImagePickerWidget(
              imageFile: selectedImage,
              imageBase64: widget.wordspace?.imageBase64,
              onTap: pickImage,
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                readOnly: widget.wordspace != null && !isediting,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requerido' : null,
              ),
            ),
            const SizedBox(height: 24),
            if (widget.wordspace == null || isediting)
              ElevatedButton(
                onPressed: _saveWordspace,
                child: Text(
                  widget.wordspace == null ? 'Guardar' : 'Actualizar',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
