import 'package:flutter/material.dart';
import 'package:pool_connection/module/auth/login/widget/form_login.dart';
import 'package:pool_connection/module/auth/login/widget/form_register.dart';
import 'package:pool_connection/module/reset_password/page/reset_password_page.dart';
import 'package:pool_connection/shared/storage/user_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool pinCreated = false;

  void isPinCreated() async {
    final data = await UserStorage().getPin();
    if (data != null) {
      pinCreated = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    isPinCreated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pinCreated)
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ResetPasswordPage(),
                  ),
                ),
                child: Text('restablecer contraseña'),
              ),
            Title(
              color: Colors.black,
              child: Text((pinCreated) ? 'Login' : 'Registro'),
            ),
            (pinCreated)
                ? const LoginForm()
                : const RegisterForm(isRecovery: false),
            const Text('Version 1.0.0'),
          ],
        ),
      ),
    );
  }
}
