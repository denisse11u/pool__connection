import 'package:flutter/material.dart';
import 'package:pool_connection/module/credential/widget/credential_form.dart';

class CredentialListPage extends StatefulWidget {
  const CredentialListPage({super.key});

  @override
  State<CredentialListPage> createState() => _CredentialListPageState();
}

class _CredentialListPageState extends State<CredentialListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Baúl de Conexiones')),
        leading: IconButton(
          icon: Icon(Icons.add_circle_outline_sharp),
          onPressed: () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  CredentialForm(),
            ),
          ),
        ),
      ),
    );
  }
}
