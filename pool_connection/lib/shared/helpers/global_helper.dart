import 'package:flutter/material.dart';

class GlobalHelper {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar({
    required BuildContext context,
    required String message,
    required Color colorSnackBar,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      backgroundColor: colorSnackBar,
      content: Text(message),
      duration: Duration(seconds: 2),
      // action: SnackBarAction(
      //   textColor: Colors.white,
      //   label: 'Cerrar',
      //   onPressed: () {},
      // ),
    );

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccess(BuildContext context, String message) {
    snackBar(context: context, message: message, colorSnackBar: Colors.green);
  }

  static void showError(BuildContext context, String message) {
    snackBar(context: context, message: message, colorSnackBar: Colors.red);
  }

  static Route navigationFadeInPage(
    BuildContext context,
    Widget page,
    int? milliseconds,
  ) {
    milliseconds ??= 800;

    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: milliseconds),
      pageBuilder: (_, animation, __) =>
          FadeTransition(opacity: animation, child: page),
    );
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // static final logger = Logger(
  //   printer: PrettyPrinter(
  //     methodCount: 0,
  //     errorMethodCount: 8,
  //     lineLength: 120,
  //     colors: true,
  //     printEmojis: false,
  //   ),
  // );
}
