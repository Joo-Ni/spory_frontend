import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'tab/location/location_model.dart';
import 'tab/tab_page.dart'; // auth_gate 사용시(tab_page로 바로 이동x일 경우) 주석처리
// import 'auth/auth_gate.dart';    // auth_gate 사용시 주석 해제

void main() async {
  // 네이버 지도
  await NMapService.initializeNaverMap();
  // 위치 정보(main->(auth)->tabPage->locationPage)
  LocationData? locationData;
  try {
    locationData = await LocationService.getLocationData();
  } catch (e) {
    debugPrint("위치 정보를 가져오는 데 실패했습니다: $e");
  }

  runApp(MyApp(locationData: locationData));
}

class MyApp extends StatelessWidget {
  final LocationData? locationData; // nullable로 선언
  const MyApp({required this.locationData, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: TabPage(locationData: locationData), // 로그인 없이 메인 페이지로 이동
      // home: AuthGate(locationData: locationData),  // 로그인 페이지로 이동
    );
  }
}
