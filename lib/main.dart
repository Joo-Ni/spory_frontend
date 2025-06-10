import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'tab/location/location_model.dart';
import 'tab/tab_page.dart';

void main() async {
  await NMapService.initializeNaverMap();
  LocationData? locationData;
  try {
    locationData = await LocationService.getLocationData();
  } catch (e) {
    debugPrint("위치 정보를 가져오는 데 실패했습니다: $e");
    // 사용자에게 오류를 알리거나 기본 위치를 설정하는 등의 추가 처리가 필요할 수 있습니다.
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
      home: TabPage(),
    );
  }
}
