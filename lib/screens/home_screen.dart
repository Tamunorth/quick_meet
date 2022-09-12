import 'package:flutter/material.dart';
import 'package:quick_meet/screens/meetings_history_screen.dart';
import 'package:quick_meet/screens/settings_screen.dart';
import 'package:quick_meet/utils/colors.dart';

import 'meeting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    MeetingScreen(),
    MeetingsHistoryScreen(),
    Center(child: Text('Contacts')),
    SettingsScreen(),
  ];

  int _page = 0;
  _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Meet and chat'),
        centerTitle: true,
        backgroundColor: Pallets.backgroundColor,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Pallets.footerColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _page,
          onTap: _onPageChanged,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.comment_bank,
                ),
                label: 'Meet and Chat'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.lock_clock,
                ),
                label: 'Meeting'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                label: 'Contacts'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: 'Settings'),
          ]),
    );
  }
}
