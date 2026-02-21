import 'package:flutter/material.dart';
import 'package:pool_connection/module/auth/login/widget/pin_text_form.dart';
import 'package:pool_connection/module/home/page/home_page.dart';
import 'package:pool_connection/shared/helpers/global_helper.dart';
import 'package:pool_connection/shared/storage/user_storage.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // void login() {
  //   //haces el login
  //   Navigator.pushReplacement(
  //     context,
  //     PageRouteBuilder(
  //       pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
  //     ),
  //   );
  // }

  Future<void> validatePin(String value) async {
    final savedPin = await UserStorage().getPin();

    if (value != savedPin) {
      GlobalHelper.showError(context, "PIN incorrecto");
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PinTextForm(
              onfinish: (value) {
                validatePin(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
