import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pool_connection/models/wordspace_model.dart';
import 'package:pool_connection/shared/storage/wordspace_storage.dart';
import 'package:pool_connection/shared/widget/image_picker_widget.dart';
import 'package:pool_connection/shared/widget/text_form_field.dart';

class CredentialForm extends StatefulWidget {
  final Credential? credential;
  final int wordspaceId;

  const CredentialForm({super.key, this.credential, required this.wordspaceId});

  @override
  State<CredentialForm> createState() => _CredentialFormState();
}

class _CredentialFormState extends State<CredentialForm> {
  late final TextEditingController nameController;
  late final TextEditingController userController;
  late final TextEditingController passwordController;
  late final TextEditingController urlController;
  late final TextEditingController notesController;

  File? selectedImage;
  final _formKey = GlobalKey<FormState>();
  final _storage = WordspaceStorage();
  bool isediting = false;

  @override
  void initState() {
    super.initState();
    isediting = widget.credential == null;
    nameController = TextEditingController(text: widget.credential?.name ?? '');
    userController = TextEditingController(text: widget.credential?.user ?? '');
    passwordController = TextEditingController(
      text: widget.credential?.password ?? '',
    );
    urlController = TextEditingController(text: widget.credential?.url ?? '');
    notesController = TextEditingController(
      text: widget.credential?.notes ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    userController.dispose();
    passwordController.dispose();
    urlController.dispose();
    notesController.dispose();

    super.dispose();
  }

  Future<void> pickImage() async {
    if (!isediting) return;
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => selectedImage = File(picked.path));
  }

  Credential createCredential() {
    final image = selectedImage != null
        ? base64Encode(selectedImage!.readAsBytesSync())
        : widget.credential?.imageBase64;

    return Credential(
      id: widget.credential?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: nameController.text.trim(),
      user: userController.text.trim(),
      password: passwordController.text.trim(),
      url: urlController.text.trim(),
      notes: notesController.text.trim(),
      imageBase64: image,
    );
  }

  Future<void> _saveCredential() async {
    if (!_formKey.currentState!.validate()) return;
    final credential = createCredential();
    if (widget.credential == null) {
      await _storage.addCredential(widget.wordspaceId, credential);
    } else {
      await _storage.updateCredential(widget.wordspaceId, credential);
      setState(() => isediting = false);
    }
    Navigator.pop(context, true);
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => CredentialListPage(wordspaceId: widget.wordspaceId),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nueva Conexión"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (!isediting && widget.credential != null)
            IconButton(
              onPressed: () => setState(() => isediting = true),
              icon: Icon(Icons.edit),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ImagePickerWidget(
              imageFile: selectedImage,
              imageBase64: widget.credential?.imageBase64,
              onTap: pickImage,
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  TextFormFieldWidget(
                    hintText: 'nombre',
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    readOnly: widget.credential != null && !isediting,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Requerido' : null,
                    obscureText: false,
                  ),

                  const SizedBox(height: 12),
                  TextFormFieldWidget(
                    hintText: 'usuario',
                    controller: userController,
                    decoration: const InputDecoration(labelText: 'Usuario'),
                    readOnly: widget.credential != null && !isediting,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Requerido' : null,
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),

                  TextFormFieldWidget(
                    hintText: 'contraseña',

                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    readOnly: widget.credential != null && !isediting,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Requerido' : null,
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),

                  TextFormFieldWidget(
                    hintText: 'URL',

                    controller: urlController,
                    decoration: const InputDecoration(labelText: 'URL'),
                    readOnly: widget.credential != null && !isediting,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Requerido' : null,
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),

                  TextFormFieldWidget(
                    hintText: 'Nota',

                    controller: notesController,
                    decoration: const InputDecoration(labelText: 'Notas'),
                    readOnly: widget.credential != null && !isediting,
                    validator: (value) => null,
                    obscureText: false,
                    // maxline: 3
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (isediting)
              ElevatedButton(
                onPressed: _saveCredential,
                child: Text(
                  widget.credential == null ? 'Guardar' : 'Actualizar',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
