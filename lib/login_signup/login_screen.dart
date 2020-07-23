import 'package:flutter/material.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:login_curiio/home/menu_dashboard_layout.dart';
import '../auth.dart';
import 'sign_up_screen.dart';
import 'Home.dart';
import 'Login_field.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: _media.height,
        width: _media.width,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Image.asset('assets/images/people.png'),
              ),
              SignInButton(
                Buttons.Google,
                text: 'Sign in with Google',
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  _auth.signInWithGoogle().whenComplete(() {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return MenuDashboardLayout();
                    }));
                  });
                },
              ),
              SizedBox(
                height: _media.height * 0.02,
              ),
              Text('OR', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: _media.height * 0.02,
              ),
              Login(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  FlatButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignUpScreen.routeName);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}