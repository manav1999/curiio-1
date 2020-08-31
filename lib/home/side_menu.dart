import 'package:flutter/material.dart';
import '../auth.dart';
import './first_screen.dart';

class SideMenu extends StatelessWidget {
  final AuthService _auth = AuthService();
  final userName;
  final userEmail;

  SideMenu(this.userName, this.userEmail);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.indigo,
          Colors.deepPurple,
        ], //colors to be changed once theme is finalised
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture:
                CircleAvatar(child: Icon(Icons.account_circle)),
            accountName: Text('Welcome, $userName'),
            accountEmail: Text(userEmail),
            decoration: BoxDecoration(color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.dashboard),
            label: Text('Dashboard'),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.share),
            label: Text('Share your progress'),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.link),
            label: Text('Link Parent Account'),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.help),
            label: Text('Help'),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
          Expanded(
            child: Container(),
          ),
          FlatButton.icon(
            onPressed: () {
              _auth.GoogleSignOut();
              _auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) {
                    return FirstScreen();
                  },
                ),
                ModalRoute.withName('/'),
              );
            },
            icon: Icon(Icons.power_settings_new),
            label: Text('Logout'),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
