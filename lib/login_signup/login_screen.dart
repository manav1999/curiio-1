import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:login_curiio/home/first_login.dart';
import 'package:login_curiio/home/menu_dashboard_layout.dart';
import 'package:login_curiio/login_signup/forgot_password.dart';
import '../auth.dart';
import 'sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  String email = '';
  String pass = '';
  UserCredential user;
  bool _autovalidate = false;
  bool _validCredentials = false;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePass(String value) {
    if (value.isEmpty || value.length < 6)
      return "Enter a password 6+ chars long";
    else
      return null;
  }

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
                onPressed: () async {
                  var a = await _auth.signInWithGoogle();
                  loginHandler(a, context);
                },
              ),
              SizedBox(
                height: _media.height * 0.02,
              ),
              Text('OR', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: _media.height * 0.02,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      autovalidate: _autovalidate,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailController,
                            validator: validateEmail,
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            validator: validatePass,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                            onChanged: (val) {
                              pass = val;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            child: Text('Login'),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _validCredentials = true;
                                });
                                var a = await _auth.signIn(email, pass);
                                 await loginHandler(a, context);

                              } else {
                                setState(() {
                                  _autovalidate = true;
                                });
                              }
                            },
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (ctx) => ForgotPassword()));
                },
                child: Text('Forgot Password?'),
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

  void _userCheck(userID, context) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) {
      if (value.exists) {
        print("User exists");
        Map<String, dynamic> data = value.data();

        Navigator.of(context).pushNamed(MenuDashboardLayout.routeName);
      } else {
        print("user does not exists");
        Navigator.of(context).pushNamed(FirstTimeLogin.routeName);
      }
    });
  }
  Future<void> loginHandler(var a, context) {
    if (a is UserCredential) {
      if (a.user != null) {
        _userCheck(a.user.uid, context);
      }
      else {
        print("User is null");
      }
    }  else {
      Flushbar(
        message:
        "${a.toString()}:Error",
        flushbarStyle: FlushbarStyle.FLOATING,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 5),
      )
        ..show(context);
      print("${a.toString()}");
    }
  }

}
