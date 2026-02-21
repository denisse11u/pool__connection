import 'package:flutter/material.dart';

class CredentialForm extends StatefulWidget {
  const CredentialForm({super.key});

  @override
  State<CredentialForm> createState() => _CredentialFormState();
}

class _CredentialFormState extends State<CredentialForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('data')));
  }
}
