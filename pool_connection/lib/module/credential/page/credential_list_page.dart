import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pool_connection/models/wordspace_model.dart';
import 'package:pool_connection/module/credential/widget/credential_form.dart';
import 'package:pool_connection/module/home/page/home_page.dart';
import 'package:pool_connection/shared/helpers/global_helper.dart';
import 'package:pool_connection/shared/storage/wordspace_storage.dart';
import 'package:pool_connection/shared/widget/alertdialog.dart';

class CredentialListPage extends StatefulWidget {
  final int? wordspaceId;
  const CredentialListPage({super.key, this.wordspaceId});

  @override
  State<CredentialListPage> createState() => _CredentialListPageState();
}

class _CredentialListPageState extends State<CredentialListPage> {
  final storage = WordspaceStorage();
  List<Credential> credential = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadListCredential();
  }

  Future<void> loadListCredential() async {
    final wordspaces = await storage.getAllWordspaces();
    final ws = wordspaces.firstWhere(
      (w) => w.id == widget.wordspaceId,
      orElse: () =>
          WordspaceModel(id: 0, name: '', description: '', credentials: []),
    );
    setState(() {
      credential = ws.credentials;
      isLoading = false;
    });
  }

  Future<void> deleteCredential(int credentialId) async {
    await storage.deleteCredential(widget.wordspaceId!, credentialId);
    loadListCredential();

    GlobalHelper.showSuccess(context, 'eliminado correctamente');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baúl de Conexiones'),
        centerTitle: true,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  HomePage(),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline_sharp),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CredentialForm(wordspaceId: widget.wordspaceId!),
                ),
              );
              if (result == true) loadListCredential();
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: credential.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final c = credential[index];
                return Card(
                  child: ListTile(
                    leading: c.imageBase64 != null
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(
                              base64Decode(c.imageBase64!),
                            ),
                          )
                        : const CircleAvatar(child: Icon(Icons.vpn_key)),
                    title: Text(c.name),
                    subtitle: Text(c.user),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CredentialForm(
                            credential: c,
                            wordspaceId: widget.wordspaceId!,
                          ),
                        ),
                      );
                      if (result == true) loadListCredential();
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),

                      onPressed: () async {
                        if (await showConfirmDialog(
                          context,
                          title: "Eliminar conexión",
                          message:
                              "¿Seguro que quieres eliminar esta conexión?",
                        )) {
                          await deleteCredential(c.id);
                        }
                      },
                    ),
                  ),
                );

                // return DismissibleCard(
                //   itemKey: c.id.toString(),
                //   onDelete: () => deleteCredential(c.id),

                //   child: Card(
                //     child: ListTile(
                //       leading: c.imageBase64 != null
                //           ? CircleAvatar(
                //               backgroundImage: MemoryImage(
                //                 base64Decode(c.imageBase64!),
                //               ),
                //             )
                //           : const CircleAvatar(child: Icon(Icons.vpn_key)),
                //       title: Text(c.name),
                //       subtitle: Text(c.user),
                //       onTap: () async {
                //         final result = await Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (_) => CredentialForm(
                //               credential: c,
                //               wordspaceId: widget.wordspaceId!,
                //             ),
                //           ),
                //         );
                //         if (result == true) loadListCredential();
                //       },
                //       // trailing: IconButton(
                //       //   icon: const Icon(Icons.delete, color: Colors.red),

                //       //   onPressed: () async {
                //       //     if (await showConfirmDialog(
                //       //       context,
                //       //       title: "Eliminar conexión",
                //       //       message:
                //       //           "¿Seguro que quieres eliminar esta conexión?",
                //       //     )) {
                //       //       await deleteCredential(c.id);
                //       //     }
                //       //   },
                //       // ),
                //     ),
                //   ),
                // );
              },
            ),
    );
  }
}
