import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up-screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _checkBox = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  void _togglePrivacyPolicy() {
    setState(() {
      _checkBox = !_checkBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: _media.height,
          width: _media.width,
          padding: const EdgeInsets.all(15),
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
                onPressed: () {},
              ),
              SizedBox(height: 10),
              SignInButton(
                Buttons.Facebook,
                text: 'Sign up with Facebook',
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {},
              ),
              SizedBox(
                height: 10,
              ),
              Text('Or sign up with your email id',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email id',
                ),
                controller: emailController,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                controller: passwordController,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Re-enter password',
                ),
                controller: repasswordController,
              ),
              SizedBox(
                height: 20,
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
                  SizedBox(width: 10),
                  Text('I agree with the Privacy Policy.'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Sign Up'),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
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
