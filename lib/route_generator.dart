import 'package:flutter/material.dart';
import 'package:login_curiio/home/first_login.dart';
import 'package:login_curiio/home/menu_dashboard_layout.dart';
import 'package:login_curiio/home/onBoarding_screen.dart';
import 'package:login_curiio/home/splashScreen.dart';
import 'package:login_curiio/home/video_lectures_screen.dart';
import 'package:login_curiio/login_signup/login_screen.dart';
import 'package:login_curiio/login_signup/sign_up_screen.dart';
import 'main.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=>SplashScreen());
        break;
      case '/login-screen':
        return MaterialPageRoute(builder: (_)=>LoginScreen());
        break;
      case '/sign-up-screen':
        return MaterialPageRoute(builder: (_)=>SignUpScreen());
       break;
      case '/menu_dashboard_layout' :
        return MaterialPageRoute(builder: (_)=>MenuDashboardLayout());
        break;
      case 'video-lecs' :
        return MaterialPageRoute(builder: (_)=>VideoLecturesScreen());
        break;
      case '/first_time_login':
        return MaterialPageRoute(builder: (_)=>FirstTimeLogin());
        break;
      case '/onBoarding_screen':
        return MaterialPageRoute(builder: (_)=>OnBoardingScreen());
        break;
    }
  }
}