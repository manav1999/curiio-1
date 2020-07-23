//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './SignUp_field.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../auth.dart';
import 'Home.dart';
import '../home/menu_dashboard_layout.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/sign-up-screen';
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
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).padding.top),
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              const Text(
                'Please register with Curiio to avail it\'s content!',
              ),
              Container(
                //padding: const EdgeInsets.all(10),
                //margin: const EdgeInsets.all(10),
                child: Image.asset('assets/images/welcome.png'),
              ),
              SignInButton(
                Buttons.Google,
                text: 'Sign up with Google',
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  _auth.signInWithGoogle().whenComplete(() {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return MenuDashboardLayout(); //_auth.email, _auth.name
                    }));
                  });
                },
              ),
              SizedBox(height: 10),
              Text('Or sign up with your email id',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Register(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  FlatButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
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
