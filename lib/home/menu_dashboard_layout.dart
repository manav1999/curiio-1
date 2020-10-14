import 'package:flutter/material.dart';

import 'package:login_curiio/home/dashboard.dart';

class MenuDashboardLayout extends StatelessWidget {
  static const routeName = '/menu_dashboard_layout';

  final String userName = 'Lorem Ipsum';
  final String userEmail = 'email@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Dashboard(),
      ),
    );
  }
}
