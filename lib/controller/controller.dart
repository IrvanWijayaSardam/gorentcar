import 'package:flutter/material.dart';

import '../profileuser/profileuser.dart';
import '../riwayat/riwayat.dart';
import '../homeUser/homeview.dart';

class controllerhome extends StatefulWidget {
  const controllerhome({super.key});

  @override
  State<controllerhome> createState() => _controllerhomeState();
}

class _controllerhomeState extends State<controllerhome> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    homeviewbg(),
    riwayat(),
    profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(65, 67, 106, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
