import 'package:flutter/material.dart';
import 'package:login_curiio/home/splashScreen.dart';
import 'home/first_screen.dart';
import './login_signup/login_screen.dart';
import './login_signup/sign_up_screen.dart';
import './home/menu_dashboard_layout.dart';
//import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curiio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(123, 112, 146, 1),
        accentColor: Colors.purple[300],
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        '/': (ctx) => SplashScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        MenuDashboardLayout.routeName: (ctx) => MenuDashboardLayout()
      },
    );
  }
}
