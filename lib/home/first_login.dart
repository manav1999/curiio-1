import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_curiio/home/menu_dashboard_layout.dart';

class FirstTimeLogin extends StatefulWidget {
  static const routeName = '/first_time_login';

  @override
  _FirstTimeLoginState createState() => _FirstTimeLoginState();
}

class _FirstTimeLoginState extends State<FirstTimeLogin> {
  String _name = "";
  int _age;
  String uid;
  String _gender = 'Non Binary';
  List<String> genderList = ["Female", "Male ", "Non Binary"];
  final _formkey = GlobalKey<FormState>();

  bool _autovalidate = true;
  bool _ontap = false;

  String validateName(String value) {
    if (value.isEmpty) {
      return "Please enter your name.";
    } else {
      return null;
    }
  }

  String validateAge(String value) {
    if (value.isEmpty) {
      return "Please enter your age.";
    } else {
      return null;
    }
  }

  @override
  void initState() {
    getUser().then((user) {
      if (user != null) {
        uid = user.uid;
      } else {
        print("user not signed in");
      }
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> addUser(uid) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(uid)
        .set({'name': _name, "age": _age, 'entry_score': 3}).then((value) {
      print("user added");
      Navigator.of(context).pushNamed(MenuDashboardLayout.routeName);
    }).catchError((error) => print("Error $error"));
  }

  Future<User> getUser() async {
    User user = await FirebaseAuth.instance.currentUser;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _ontap
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Center(
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formkey,
                        autovalidate: _autovalidate,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "We would like to know you better!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              thickness: 0.7,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              validator: validateName,
                              decoration: InputDecoration(
                                labelText: "Name",
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              validator: validateAge,
                              decoration: InputDecoration(
                                labelText: "Age",
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _age = int.parse(value);
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            /*DropdownButton(
                                  value: _gender,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 18,
                                  elevation: 2,
                                  items: genderList.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String newValue) {
                                    if (newValue == genderList[0] ||
                                        newValue == genderList[1] ||
                                        newValue == genderList[2]) {
                                      setState(() {
                                        _gender = newValue;
                                      });
                                    }else{
                                      setState(() {
                                        _gender="Select Gender";
                                      });
                                    }
                                  },
                          ),*/
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              child: Text("Submit"),
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(
                                    () {
                                      _ontap = true;
                                    },
                                  );
                                  print("$_name $_age, $_gender");
                                  print(uid);
                                  var user = await addUser(uid);
                                  print('user added');
                                } else {
                                  setState(
                                    () {
                                      _autovalidate = true;
                                    },
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
