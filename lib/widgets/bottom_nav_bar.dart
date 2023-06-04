import 'package:firebase_crud/screens/post_screen.dart';
import 'package:firebase_crud/screens/profile_screen.dart';
import 'package:firebase_crud/screens/to_do_screen.dart';
import 'package:flutter/material.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => MyBottomNavBarState();
}

class MyBottomNavBarState extends State<MyBottomNavBar> {
  static int bottomNavigationTabIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    TodoListScreen(),
    PostScreen(),
    ProfileScreen(),
  ];

  //Implementing Bottom Navigation Bar

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(bottomNavigationTabIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.check_box,
                ),
                icon: Icon(Icons.check_box_outlined),
                label: 'Todo',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.feed),
                icon: Icon(Icons.feed_outlined),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.person),
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
            currentIndex: bottomNavigationTabIndex,
            onTap: (int index) {
              setState(() {
                bottomNavigationTabIndex = index;
              });
            }),
      ),
    );
  }
}
