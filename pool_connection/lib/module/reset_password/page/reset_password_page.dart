import 'package:flutter/material.dart';
import 'package:pool_connection/module/auth/login/page/login_page.dart';
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  LoginPage(),
            ),
          ),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(child: SafeArea(child: RegisterForm(isRecovery: true))),
    );
  }
}
