// lib/tab/tab_page.dart
import 'package:flutter/material.dart';
// import 'package:location/location.dart'; // 더 이상 여기서 직접 사용하지 않습니다.
// import 'package:sports_connect/location/location_model.dart'; // 더 이상 여기서 직접 초기화하지 않습니다.

import 'account/account_page.dart';
import 'home/home_page.dart';
import 'location/location_page.dart'; // LocationPage
import 'search/search_page.dart';
import 'story/story_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;
  // LocationData? locationData; // 더 이상 여기서 직접 관리하지 않습니다.

  @override
  void initState() {
    super.initState();
  }

  // Future<void> _initializeServices() async { /* 이 함수는 이제 필요 없습니다. */ }

  List<Widget> getPages() {
    return [
      HomePage(),
      LocationPage(), // <--- 여기서 locationData 인자를 제거했습니다.
      SearchPage(),
      StoryPage(),
      AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPages()[_currentIndex],
      bottomNavigationBar: Container(
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
              icon: Icon(Icons.fitness_center_rounded),
              label: 'Spory',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '마이페이지',
            ),
          ],
          selectedItemColor: const Color.fromARGB(255, 43, 180, 153),
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
