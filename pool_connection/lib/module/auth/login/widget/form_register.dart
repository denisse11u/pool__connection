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
  /////
  ///fd
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

  // Future<void> saveSecurityWord(String value) async {
  //   await UserStorage().setSecurityWord(value);

  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (_) => const HomePage()),
  //   );
  // }

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

  //  Future<void> confirmPin(String value) async {
  //     if (mode == PinMode.confirm) {
  //       if (value == firstPin) {
  //         await storage.savePin(value);
  //         GlobalHelper.showSuccess(context, "pin creado");

  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (_) => const HomePage()),
  //         );
  //       } else {
  //         GlobalHelper.showError(context, "no coincide con el pin creado");
  //         controller.clear();
  //         setState(() => mode = PinMode.create);
  //       }
  //       return;
  //     }
  //   }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (pinCompleted)
          ? Column(
              children: [
                Text('Palabra de seguridad'),
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
                ),
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
          : PinTextForm(
              onfinish: (value) {
                savePin(value);
              },
            ),
    );
  }
}
