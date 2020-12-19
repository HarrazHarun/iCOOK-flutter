import 'package:flutter/material.dart';
import 'package:iCOOK/Screens/recipe_screen.dart';
import 'package:iCOOK/Screens/scan_screen.dart';
import 'package:iCOOK/Screens/tips_screen.dart';
import 'package:iCOOK/Screens/update_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 3;
  final List<Widget> _children = [
    ScanScreen(),
    RecipesScreen(),
    TipsScreen(),
    UpdateScreen(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        iconSize: 30,
        selectedFontSize: 15,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.linked_camera),
              // ignore: deprecated_member_use
              title: Text('Camera'),
              backgroundColor: Colors.lightGreen),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              // ignore: deprecated_member_use
              title: Text('Recipes'),
              backgroundColor: Colors.lightGreen),
          BottomNavigationBarItem(
              icon: Icon(Icons.rule),
              // ignore: deprecated_member_use
              title: Text('Tips'),
              backgroundColor: Colors.lightGreen),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              // ignore: deprecated_member_use
              title: Text('Profile'),
              backgroundColor: Colors.lightGreen),
        ],
      ),
    );
  }
}
