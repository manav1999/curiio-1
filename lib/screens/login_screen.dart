import 'package:flutter/material.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

import './sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';

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
                onPressed: () {},
              ),
              SizedBox(height: 20),
              SignInButton(
                Buttons.Facebook,
                text: 'Sign in with Facebook',
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {},
              ),
              SizedBox(
                height: 20,
              ),
              Text('OR', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'User Name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Login'),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
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
