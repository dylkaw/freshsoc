import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:freshsoc/screens/home/home.dart';
import 'package:freshsoc/screens/settings/settings.dart';
import 'package:freshsoc/screens/soccess/soccess.dart';
import 'package:freshsoc/screens/socchat/socchat.dart';
import 'package:freshsoc/screens/socialize/create_post.dart';
import 'package:freshsoc/screens/socialize/socialize.dart';

class NavigationController extends StatefulWidget {
  int selectedIndex;
  NavigationController({super.key, required this.selectedIndex});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  final List<Widget> _screens = [
    Home(),
    Socialize(),
    Socchat(),
    Soccess(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 126, 145, 154),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined), label: "SoCialize"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined), label: "SoCChat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined), label: "SoCcess"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: "Settings")
        ],
        onTap: (i) {
          setState(() {
            widget.selectedIndex = i;
          });
        },
        currentIndex: widget.selectedIndex,
      ),
    );
  }
}
