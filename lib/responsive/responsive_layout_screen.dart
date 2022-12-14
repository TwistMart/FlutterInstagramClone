import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget
      mobileScreenLayout; // final means once declared cannot be changed,
  final Widget webScreenLayout;

  const ResponsiveLayout(
      {required this.mobileScreenLayout, // require the mobile and webScreenLayout via the constructor
      required this.webScreenLayout,
      super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      //LayoutBuilder helps in creating responsive layout
      // gives us builder function which will return a context and a constraints and constraints in turn comes with maxWidth, minWidth, maxHeight, minHeight
      if (constraints.maxWidth > webScreenSize) {
        // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout

        // web Screen
        return widget
            .webScreenLayout; // beyond 600 it will display webScreenLayout
      }

      // mobile screen

      return widget.mobileScreenLayout;
    });
  }
}
