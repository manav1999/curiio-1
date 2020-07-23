import 'package:flutter/material.dart';

import 'side_menu.dart';
import 'dashboard.dart';

class MenuDashboardLayout extends StatelessWidget {
  final String userName = 'Lorem Ipsum';
  final String userEmail = 'email@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            SideMenu(userName, userEmail),
            Dashboard(),
          ],
        ),
      ),
    );
  }
}
