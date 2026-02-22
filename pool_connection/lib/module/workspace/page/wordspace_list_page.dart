import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pool_connection/models/wordspace_model.dart';
import 'package:pool_connection/module/credential/page/credential_list_page.dart';
import 'package:pool_connection/module/workspace/widget/wordspace_form.dart';
import 'package:pool_connection/shared/helpers/global_helper.dart';
import 'package:pool_connection/shared/storage/wordspace_storage.dart';
import 'package:pool_connection/shared/widget/alertdialog.dart';
import 'package:pool_connection/shared/widget/app_card.dart';

class WordspaceListPage extends StatefulWidget {
  const WordspaceListPage({super.key});

  @override
  State<WordspaceListPage> createState() => _WordspaceListPageState();
}

class _WordspaceListPageState extends State<WordspaceListPage> {
  @override
  void initState() {
    super.initState();
    loadListWordspaces();
  }

  final storage = WordspaceStorage();
  List<WordspaceModel> wordspaces = [];
  bool isLoading = true;

  Future<void> loadListWordspaces() async {
    final data = await storage.getAllWordspaces();
    setState(() {
      wordspaces = data;
      isLoading = false;
    });
  }

  Future<void> deleteWordspace(int id) async {
    await storage.deleteWordspace(id);
    await loadListWordspaces();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return wordspaces.isEmpty
        ? Center(child: Text(' no hay espacios creados'))
        : ListView.builder(
            itemCount: wordspaces.length,
            itemBuilder: (context, index) {
              final wordspace = wordspaces[index];

              return AppCard(
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WordspaceForm(wordspace: wordspace),
                        ),
                      );
                      if (result == true) loadListWordspaces();
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: wordspace.imageBase64 != null
                          ? MemoryImage(base64Decode(wordspace.imageBase64!))
                          : null,
                      child: wordspace.imageBase64 == null
                          ? const Icon(Icons.photo)
                          : null,
                    ),
                  ),
                  title: Text(wordspace.name),
                  subtitle: Text('${wordspace.credentials.length} conexiones'),

                  // subtitle: Text(wordspace.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),

                    onPressed: () async {
                      if (await showConfirmDialog(
                        context,
                        title: "Eliminar conexión",
                        message: "¿Seguro que quieres eliminar esta conexión?",
                      )) {
                        await storage.deleteWordspace(wordspace.id);
                        setState(() => wordspaces.removeAt(index));
                      }
                      GlobalHelper.showSuccess(
                        context,
                        'eliminado correctamente',
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CredentialListPage(wordspaceId: wordspace.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
}
