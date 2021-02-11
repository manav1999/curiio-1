import 'package:flutter/material.dart';
import 'package:login_curiio/home/first_login.dart';
import 'package:login_curiio/home/onBoarding_screen.dart';

import 'package:login_curiio/home/splashScreen.dart';
import 'package:login_curiio/home/video_lectures_screen.dart';
import 'package:login_curiio/route_generator.dart';
import 'package:login_curiio/theme.dart';

//import 'home/first_screen.dart';
import './login_signup/login_screen.dart';
import './login_signup/sign_up_screen.dart';
import './home/menu_dashboard_layout.dart';
import 'home/menu_dashboard_layout.dart';
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
      theme: currioTheme,
    /*  routes: {
        '/': (ctx) => SplashScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        MenuDashboardLayout.routeName: (ctx) => MenuDashboardLayout(),
        VideoLecturesScreen.routeName: (ctx) => VideoLecturesScreen(),
        FirstTimeLogin.routeName: (ctx) => FirstTimeLogin(),
        OnBoardingScreen.routeName:(ctx) => OnBoardingScreen()
      },*/initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute, 
    );
  }
}
