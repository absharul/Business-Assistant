import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_app/constants/color.dart';

import '../homepage.dart';
import '../show_details.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {

  int _selectedIndex = 0;

  static  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text("Invoice Page"),
    ShowDetails(),
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
        backgroundColor: AppColor.bottomNavColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Invoice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Saved Forms',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.appBarColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
