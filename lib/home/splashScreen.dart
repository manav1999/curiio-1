import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_curiio/auth.dart';
import 'package:login_curiio/home/first_login.dart';
import 'package:login_curiio/home/menu_dashboard_layout.dart';
import 'package:login_curiio/home/onBoarding_screen.dart';
import 'package:login_curiio/login_signup/sign_up_screen.dart';
import 'dart:async';
import '../login_signup/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _userID;
  String _userName;
  bool _isRegistered;

  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (_userID == null) {
      //if user does not exist,Login
      Navigator.of(context).pushNamed(OnBoardingScreen.routeName);
    } else {
      if (_isRegistered == false) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return FirstTimeLogin();
          },
        ));
        //if user exist but not registered,first_login

      } else if (_isRegistered == true) {
        Navigator.of(context).pushNamed(MenuDashboardLayout.routeName);
      }
    }
  }

  void initState() {
    super.initState();
    //Initializing firebase
    Firebase.initializeApp().then((value) {
      //timer
     startTime();
      final _auth = AuthService();
      //Get user Status
      _auth.userdata.listen((User user) {
        if (user == null) {
          _userID = null;
        } else {
          _userID = user.uid;
          _userCheck();
        }
      });
    }).catchError((e) {
      print("ERROR ${e.toString()}");
    });
  }

  void _userCheck() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(_userID)
        .get()
        .then((value) {
      if (value.exists) {
        print("User exists");
        Map<String, dynamic> data = value.data();
        _userName = data['name'];
        _isRegistered = true;
      } else {
        print("user does not exists");
        _isRegistered = false;
      }
    });
    /* Firestore.instance
        .collection("users")
        .document(_userID)
        .get()
        .then((value) {
      if (value.exists) {
        print("User exists");
        _userName = value.data['name'];
        _isRegistered = true;
      } else {
        print("user does not exist");
        _isRegistered = false;
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              child: Text(
                'Curiio',
              style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              strokeWidth: 5,
            ),
          )
        ],
      ),
    );
  }
}
