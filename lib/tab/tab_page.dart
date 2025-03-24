import 'package:flutter/material.dart';

import 'account/account_page.dart';
import 'home/home_page.dart';
import 'lacation/location_page.dart';
import 'search/search_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;

  final _pages = [
    // 변하지 않을 것이므로 final
    HomePage(),
    LocationPage(),
    SearchPage(),
    AccountPage(),
    // ProfileScreen(
    //   providers: [
    //     EmailAuthProvider(),
    //   ],
    //   avatarSize: 24,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        width: 375,
        height: 78,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 0,
              offset: Offset(0, -0.50),
              spreadRadius: 0,
            )
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.place),
              label: '지도',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '카테고리',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '마이페이지',
            ),
          ],
          selectedItemColor: Color.fromARGB(255, 43, 180, 153), // 선택된 아이템 색상
          unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상
        ),
      ),
    );
  }
}
