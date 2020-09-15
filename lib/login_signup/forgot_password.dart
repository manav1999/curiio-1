import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String _enteredEmail;
  bool _emailExists = true;
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        setState(() {
          _isLoading = false;
          _emailSent = true;
          _emailExists = true;
        });
      });
    } catch (error) {
      print(error);
      print('invalid email adresss');
      setState(() {
        _emailExists = false;
        _isLoading = false;
        _emailSent = false;
      });
    }
  }

  String _validate(String email) {
    //_checkIfEmailExists(email);
    resetPassword(email);
    if (email.isEmpty) return 'Please enter a valid email id.';
    return null;
  }

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Please enter your registered email id.'),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _enteredEmail = val;
                    });
                  },
                  validator: _validate,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    _trySubmit();
                  },
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (!_emailExists)
                  Text('This email id is not registered with us. Try again'),
                if (_isLoading) CircularProgressIndicator(),
                if (_emailSent)
                  Text('An email has been sent to your registered email id.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
