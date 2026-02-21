import 'package:flutter/material.dart';
import 'package:pool_connection/module/auth/login/widget/form_register.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SafeArea(child: RegisterForm(isRecovery: true))),
    );
  }
}
