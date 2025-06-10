// location/location_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:location/location.dart';
import 'package:sports_connect/tab/location/location_model.dart'; // NMapService와 LocationService가 있는 파일

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  NaverMapController? _mapController;
  LocationData? _currentLocationData; // 현재 위치 정보를 저장할 변수
  NLocationOverlay? _locationOverlay; // 현재 위치 오버레이를 저장할 변수

  final List<String> sports = [
    '축구',
    '야구',
    '농구',
    '배구',
    '테니스',
    '골프',
    '수영',
    '탁구',
    '배드민턴',
    '볼링',
  ];

  @override
  void initState() {
    super.initState();
    _fetchLocationAndSetupMap(); // 위치 정보 가져오기 및 지도 설정 함수 호출
  }

  Future<void> _fetchLocationAndSetupMap() async {
    try {
      final locationData = await LocationService.getLocationData();
      if (mounted) {
        setState(() {
          _currentLocationData = locationData;
        });
      }
      // 지도가 이미 준비되었다면 바로 오버레이 설정
      if (_mapController != null && _currentLocationData != null) {
        _updateLocationOverlay(_currentLocationData!);
        // 지도의 카메라를 현재 위치로 이동시킵니다.
        _mapController!.updateCamera(
          NCameraUpdate.fromCameraPosition(
            NCameraPosition(
              target: NLatLng(
                _currentLocationData!.latitude!,
                _currentLocationData!.longitude!,
              ),
              zoom: 15, // 원하는 줌 레벨
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint("LocationPage에서 위치 정보를 가져오는 데 실패했습니다: $e");
      // 사용자에게 메시지 표시 또는 다른 기본값 설정
    }
  }

  void _updateLocationOverlay(LocationData locData) {
    if (_mapController != null) {
      _locationOverlay = _mapController!.getLocationOverlay();

      _locationOverlay!.setIconSize(const Size.square(24));
      _locationOverlay!.setCircleRadius(20.0);
      _locationOverlay!.setCircleColor(Colors.blue.withOpacity(0.3));

      // assets/sub.png 파일이 존재해야 합니다. pubspec.yaml에도 assets 폴더를 명시해야 합니다.
      _locationOverlay!
          .setSubIcon(NOverlayImage.fromAssetImage("assets/sub.png"));
      _locationOverlay!.setSubIconSize(const Size(15, 15));
      _locationOverlay!.setSubAnchor(const NPoint(0.5, 1));

      _locationOverlay!
          .setPosition(NLatLng(locData.latitude!, locData.longitude!));

      if (locData.heading != null) {
        _locationOverlay!.setBearing(locData.heading!);
      } else {
        _locationOverlay!.setBearing(0);
      }
      _locationOverlay!.setIsVisible(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    // _currentLocationData가 null일 경우 기본값으로 서울 시청을 사용합니다.
    // 지도의 초기 위치는 이 값을 따릅니다.
    final NLatLng initialTarget = NLatLng(
      _currentLocationData?.latitude ?? 37.5665, // 현재 위치가 없으면 서울 시청 위도
      _currentLocationData?.longitude ?? 126.9780, // 현재 위치가 없으면 서울 시청 경도
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Spory'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xFFF5F5F5)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      hintText: "검색어를 입력하세요",
                      controller: controller,
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                    );
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    final suggestions = sports.where((sport) {
                      return sport
                          .toLowerCase()
                          .contains(controller.text.toLowerCase());
                    }).toList();
                    return List<ListTile>.generate(
                      suggestions.length,
                      (index) {
                        final suggestion = suggestions[index];
                        return ListTile(
                          title: Text(suggestion),
                          onTap: () {
                            controller.closeView(suggestion);
                          },
                        );
                      },
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                ),
                Container(
                  width: width,
                  height: height * 0.68,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: NaverMap(
                    options: NaverMapViewOptions(
                      locationButtonEnable: true,
                      initialCameraPosition: NCameraPosition(
                        target: initialTarget,
                        zoom: 15, // 초기 줌 레벨
                        bearing: 0,
                        tilt: 0,
                      ),
                    ),
                    onMapReady: (controller) {
                      _mapController = controller;
                      // 지도가 준비된 후, 위치 정보가 있다면 오버레이를 설정하고 카메라를 이동시킵니다.
                      if (_currentLocationData != null) {
                        _updateLocationOverlay(_currentLocationData!);
                        // 지도의 카메라를 현재 위치로 이동시킵니다.
                        _mapController!.updateCamera(
                          NCameraUpdate.fromCameraPosition(
                            NCameraPosition(
                              target: NLatLng(
                                _currentLocationData!.latitude!,
                                _currentLocationData!.longitude!,
                              ),
                              zoom: 15,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
