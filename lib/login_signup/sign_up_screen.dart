//import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:login_curiio/home/first_login.dart';
import 'package:login_curiio/login_signup/login_screen.dart';
import '../auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import '../home/menu_dashboard_layout.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flushbar/flushbar.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up-screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formkey = GlobalKey<FormState>();

  WebViewController _controller;
  bool showLoading = false;

  String email = '';
  String pass = '';
  String rePass = '';
  String error = '';

  bool _checkBox = false;
  bool _autovalidate = false;

  void updateLoading(bool ls) {
    setState(() {
      showLoading = ls;
    });
  }

  void _togglePrivacyPolicy() {
    setState(() {
      _checkBox = !_checkBox;
    });
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

  String validateRePass(String value) {
    if (value.isEmpty)
      return "Re-type the Password";
    else if (value != pass)
      return "Passwords do not match";
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
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
                onPressed: () async {
                  var a= await _auth.signInWithGoogle();
                  _userCheck(a.user.uid, context);
                },
              ),
              SizedBox(height: 10),
              Text('Or sign up with your email id',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Column(
                children: <Widget>[
                  Form(
                    key: _formkey,
                    autovalidate: _autovalidate,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                          decoration: InputDecoration(labelText: "Email"),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        TextFormField(
                          validator: validatePass,
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Password"),
                          onChanged: (val) {
                            pass = val;
                          },
                        ),
                        TextFormField(
                          validator: validateRePass,
                          obscureText: true,
                          decoration:
                          InputDecoration(labelText: "Re-enter Password"),
                          onChanged: (val) {
                            rePass = val;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: _checkBox
                                  ? Icon(Icons.check_box)
                                  : Icon(Icons.check_box_outline_blank),
                              onPressed: () {
                                _togglePrivacyPolicy();
                              },
                            ),
                            SizedBox(width: 20),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'I agree with the ',
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Scaffold(
                                                appBar: AppBar(
                                                  title: Text('Privacy Policy'),
                                                ),
                                                body: Stack(
                                                  children: [
                                                    WebView(
                                                      initialUrl:
                                                      'https://pub.dev/packages/webview_flutter',
                                                      onPageStarted: (url) {
                                                        updateLoading(true);
                                                        _controller
                                                            .loadUrl(
                                                            'https://pub.dev/packages/webview_flutter')
                                                            .then((val) {
                                                          updateLoading(false);
                                                        }).catchError((e) {
                                                          updateLoading(false);
                                                        });
                                                      },
                                                      onPageFinished: (url) {
                                                        updateLoading(false);
                                                      },
                                                      javascriptMode:
                                                      JavascriptMode
                                                          .unrestricted,
                                                      onWebViewCreated:
                                                          (webViewController) {
                                                        _controller =
                                                            webViewController;
                                                      },
                                                    ),
                                                    showLoading
                                                        ? Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    )
                                                        : Center(),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          child: Text('Sign Up'),
                          onPressed: _checkBox
                              ? () async {
                            if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              var a = await _auth.registerWithEmail(
                                  email, pass);
                              signUpHandle(a, context);
                            } else {
                              setState(() {
                                _autovalidate = true;
                              });
                            }
                          }
                              : null,
                          color: Theme
                              .of(context)
                              .primaryColor,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  FlatButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme
                              .of(context)
                              .primaryColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
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
  void signUpHandle(var a, context) {
    if (a is UserCredential) {
      if (a.user != null) {
        Navigator.of(context).pushNamed(FirstTimeLogin.routeName);
      }
      else {
        print("User is null");
      }
    } else if (a is FirebaseAuthException) {
      if (a.code == 'weak-password') {
        Flushbar(
          message:
          "${a.code}: Password is too weak",
          flushbarStyle: FlushbarStyle.FLOATING,
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue,
          ),
          duration: Duration(seconds: 3),
        )
          ..show(context);
        print("password is too weak");
      } else if (a.code ==
          'email-already-in-use') {
        Flushbar(
          messageText: Text(
            "${a.code}:Email already in use,", style: TextStyle(color: Theme
              .of(context)
              .primaryColor),)
          ,
          backgroundColor: Colors.white,
          flushbarStyle: FlushbarStyle.FLOATING,
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue,
          ),
          duration: Duration(seconds: 3),
          mainButton: FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            }, child: Text("Login"),
          ),
        )
          ..show(context);
        print(
            'The account already exists for that email');
      }
    } else {
      Flushbar(
        message:
        "${a.code}:Error",
        flushbarStyle: FlushbarStyle.FLOATING,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
      )
        ..show(context);
      print("Error");
    }
  }

  void onSignUp(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Sign Up successful"),
      duration: Duration(seconds: 10),
    ));
    Navigator.of(context).pop();
  }
}
