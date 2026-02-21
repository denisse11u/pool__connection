import 'package:flutter/material.dart';
import 'package:pool_connection/module/auth/login/page/login_page.dart';
import 'package:pool_connection/module/workspace/page/wordspace_list_page.dart';
import 'package:pool_connection/module/workspace/widget/wordspace_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text("Lista de conexiones")),
            IconButton(
              icon: Icon(Icons.add_circle_outline_sharp),
              onPressed: () => Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      WordspaceForm(),
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  LoginPage(),
            ),
          ),
        ),
      ),
      body: Center(child: SafeArea(child: WordspaceListPage())),
    );
  }
}
