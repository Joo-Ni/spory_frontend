import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'account/account_page.dart';
// import 'home/home_page.dart';
import 'location/location_page.dart';
import 'search/category_page.dart';
import 'story/story_page.dart';

class TabPage extends StatefulWidget {
  final LocationData? locationData;
  const TabPage({super.key, this.locationData});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> getPages() {
    return [
      // HomePage(),
      LocationPage(locationData: widget.locationData),
      CategoryPage(),
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
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.home),
            //   label: '홈',
            // ),
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
