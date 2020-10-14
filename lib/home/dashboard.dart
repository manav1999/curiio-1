import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:login_curiio/home/chatroom/new_message.dart';

import 'video_lectures_screen.dart';
import 'package:login_curiio/home/chatroom/chat_sceen.dart';
import 'package:login_curiio/home/phases_list_screen.dart';
import 'profile_screen.dart';
import 'package:login_curiio/home/first_screen.dart';
import 'package:login_curiio/auth.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    PhasesListScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  final List<String> appBarTitles = ['Phases', 'Chat Room', 'Profile'];

  Future<void> generateAlertDialog(BuildContext c) async {
    return showDialog(
      context: c,
      builder: (ctx) {
        return Dialog(
          insetPadding: EdgeInsets.all(5),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Do you have a question to ask?',
                  style: TextStyle(fontSize: 20),
                ),
                NewMessage(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: new IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          appBarTitles[_selectedPageIndex],
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: _selectedPageIndex == 1
          ? FloatingActionButton(
              child: Icon(Icons.edit_outlined),
              onPressed: () {
                setState(() {
                  generateAlertDialog(context);
                });
              },
              tooltip: 'Write a message!',
              elevation: 10,
              backgroundColor: Theme.of(context).primaryColor,
            )
          : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
        child: Drawer(
          child: DrawerItems(),
        ),
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.video_library),
          Icon(Icons.chat_bubble_outline),
          Icon(Icons.perm_identity),
        ],
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          Container(
            child: Column(
              children: [
                Container(
                  height: 150,
                  //width: 150,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
              ],
            ),
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
            icon: Icon(Icons.person),
            label: Text('Profile'),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.share),
            label: Text('Share Your Progress'),
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
          SizedBox(
            height: 20,
          ),
          FlatButton.icon(
            onPressed: () {
              _auth.googleSignOut();
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
