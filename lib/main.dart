import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'tab/location/loacation_model.dart';
import 'tab/tab_page.dart';

void main() async {
  await NMapService.initializeNaverMap();
  LocationData locationData = await LocationService.getLocationData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
