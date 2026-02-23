import 'package:flutter/material.dart';
import 'package:pool_connection/module/auth/login/widget/pin_text_form.dart';
import 'package:pool_connection/module/home/page/home_page.dart';
import 'package:pool_connection/shared/helpers/global_helper.dart';
import 'package:pool_connection/shared/storage/user_storage.dart';
import 'package:pool_connection/shared/widget/text_form_field.dart';

class RegisterForm extends StatefulWidget {
  final bool isRecovery;
  const RegisterForm({super.key, required this.isRecovery});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  void initState() {
    super.initState();
    if (widget.isRecovery) {
      pinCompleted = true;
    }
  }

  bool pinCompleted = false;
  TextEditingController _securityWordController = TextEditingController();

  // void savePin(String value) {
  //   UserStorage().setPin(value);
  //   pinCompleted = true;
  //   debugPrint('pin guardado');
  //   setState(() {});
  // }

  void savePin(String value) async {
    await UserStorage().setPin(value);

    if (widget.isRecovery) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
      return;
    }

    setState(() {
      pinCompleted = true;
    });
  }

  void saveSecurityWord(String value) {
    UserStorage().setSecurityWord(value);

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
      ),
    );
  }

  Future<void> valiSecurityWord() async {
    final saveWord = await UserStorage().getSecurityWord();

    if (_securityWordController.text.trim() != saveWord) {
      GlobalHelper.showError(context, "Palabra incorrecta");
      _securityWordController.clear();
      return;
    }
    setState(() {
      pinCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (pinCompleted)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ingrese la palabra de Seguridad'),
                const SizedBox(height: 34),
                TextFormFieldWidget(
                  controller: _securityWordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo no debe estar vacío';
                    }
                    return null;
                  },
                  obscureText: false,
                  decoration: InputDecoration(),
                  readOnly: false,
                ),
                const SizedBox(height: 25),
                OutlinedButton(
                  onPressed: () {
                    if (widget.isRecovery) {
                      valiSecurityWord();
                    } else {
                      saveSecurityWord(_securityWordController.text);
                    }
                  },

                  child: Text('Guardar'),
                ),
              ],
            )
          : Column(
              children: [
                Text('Registre su Pin'),
                PinTextForm(
                  onfinish: (value) {
                    savePin(value);
                  },
                ),
              ],
            ),
    );
  }
}
