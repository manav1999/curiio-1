import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'video_lectures_screen.dart';
import 'package:login_curiio/home/chatroom/chat_sceen.dart';
import 'package:login_curiio/home/phases_list_screen.dart';
import 'profile_screen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  bool _isCollapsed = true;
  final Duration duration = const Duration(milliseconds: 800);
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    PhasesListScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  final List<String> appBarTitles = ['Phases', 'Chat Room', 'Profile'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: _isCollapsed ? 0 : 0.45 * _media.width,
      right: _isCollapsed ? 0 : -0.4 * _media.height,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          elevation: 20,
          child: Scaffold(
            appBar: AppBar(
              title: Text(appBarTitles[_selectedPageIndex]),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                )
              ],
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    print('menu pressed');
                    if (_isCollapsed)
                      _controller.forward();
                    else
                      _controller.reverse();

                    _isCollapsed = !_isCollapsed;
                  });
                },
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
          ),
        ),
      ),
    );
  }
}
