import 'package:flutter/material.dart';
import 'package:pool_connection/module/auth/login/page/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      Future.delayed(const Duration(
        seconds: 3, 

      ), () {
        Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),));
      },);
    });
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.security, size: 120,),
            SizedBox(height: 40,),
            CircularProgressIndicator(color: Colors.white,)
          ],
        ),
      ),
    );
  }
}