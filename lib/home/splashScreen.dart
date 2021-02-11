import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_curiio/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _userID;
  String _userEmail;
  String switchCode;

  String _userName;
  bool _isRegistered;

  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    /*if (_userID == null) {
      //if user does not exist,Login
      Navigator.of(context).pushNamed(SignUpScreen.routeName);
    } else {
      if (_isRegistered == false) {
        Navigator.of(context).pushNamed(FirstTimeLogin.routeName);
        //if user exist but not registered,first_login

      } else if (_isRegistered == true) {
        Navigator.of(context).pushNamed(MenuDashboardLayout.routeName);
      }
    }*/
    switch (switchCode) {
      case 'first_run':
        {
          Navigator.of(context).pushReplacementNamed('/onBoarding_screen');
          print("onBorading Screen");
        }
        break;
      case 'not_logged_in':
        {
          Navigator.of(context).pushReplacementNamed('/sign-up-screen');
          print("User not logged in");
        }
        break;
      case 'registered':
        {
          Navigator.of(context).pushReplacementNamed('/menu_dashboard_layout');
          print("user registered");
        }
        break;
      case 'not_registered':
        {
          Navigator.of(context).pushNamed('/first_time_login');
          print("not registered");
        }
        break;
      default:
        Navigator.of(context).pushReplacementNamed('/sign-up-screen');
        break;
    }
  }

  Future<bool> checkInitialisation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool checkValue = pref.containsKey('firstRun');
    if (checkValue == false) {
      pref.setBool('firstRun', true);
      return true;
    } else {
      bool value = pref.getBool('firstRun');
      if (value) {
        print("not first login");
        return false;
      } else {
        pref.setBool('firstRun', true);
        return true;
      }
    }
  }

  void initState() {
    super.initState();
    //Initializing firebase
    Firebase.initializeApp().then((value) {
      startTime();
      checkInitialisation().then((value) {
        if (value) {
          switchCode = 'first_run';
        } else {
          final _auth = AuthService();
          //Get user Status
          _auth.userdata.listen((User user) {
            if (user == null) {
              switchCode = 'not_logged_in';
              _userID = null;
            } else {
              _userID = user.uid;
              _userCheck();
            }
          });
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
        switchCode = "registered";
        Map<String, dynamic> data = value.data();
        _userName = data['name'];
      } else {
        print("user does not exists");
        switchCode = "not_registered";
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
      backgroundColor: Color(0xff2B2F71),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: <Widget>[
      //     Center(
      //       child: Container(
      //         child: Text(
      //           'Curiio',
      //           style: Theme.of(context).textTheme.headline1,
      //         ),
      //       ),
      //     ),
      //     Container(
      //       height: 50,
      //       width: 50,
      //       child: CircularProgressIndicator(
      //         strokeWidth: 5,
      //       ),
      //     )
      //   ],
      // ),
      body: Stack(
        children: [
          Center(
              child: Container(
            margin: EdgeInsets.fromLTRB(60, 50, 40, 50),
            child: Image.asset('assets/logo/logo.png'),
          )),
          Positioned(
              bottom: 40,
              right: (MediaQuery.of(context).size.width/2)-37,
              child: Container(
                child: Lottie.asset('assets/lottie/jumpingBalls.json',width: 80),
              ))
        ],
      ),
    );
  }
}
