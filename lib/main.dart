import 'package:flutter/material.dart';
import 'package:pro/pages/login_page.dart';
import 'package:pro/pages/register_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => LoginPage(),
          );
        },
      ),
    );
  }
}
