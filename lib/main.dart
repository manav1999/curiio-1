import 'package:flutter/material.dart';

import './screens/first_screen.dart';
import './screens/login_screen.dart';
import './screens/sign_up_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curiio',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(123, 112, 146, 1),
        accentColor: Colors.purple[300],
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        '/': (ctx) => FirstScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
      },
    );
  }
}
