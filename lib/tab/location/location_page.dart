import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:location/location.dart';
// import 'package:sports_connect/tab/location/location_model.dart'; // NMapService와 LocationService가 있는 파일

class LocationPage extends StatefulWidget {
  final LocationData? locationData;
  const LocationPage({super.key, this.locationData});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  NaverMapController? _mapController;
  // LocationData? _currentLocationData; // 현재 위치 정보를 저장할 변수 이동시에 잘 되는지 확인하지 않았으므로 삭제보류
  NLocationOverlay? _locationOverlay; // 현재 위치 오버레이를 저장할 변수

  // 마커 데이터 추가방법
  // static const NLatLng _gymwayLocation = NLatLng(37.324335, 127.124953);
  // static const String _gymwayName = "짐웨이";

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
  }

  void _updateLocationOverlay(LocationData locData) {
    if (_mapController != null) {
      _locationOverlay = _mapController!.getLocationOverlay();

      _locationOverlay!.setIconSize(const Size.square(24));
      _locationOverlay!.setCircleRadius(20.0);
      _locationOverlay!.setCircleColor(Colors.blue.withOpacity(0.3));

      _locationOverlay!
          .setSubIcon(const NOverlayImage.fromAssetImage("assets/sub.png"));
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

  // 새로운 함수: 짐웨이 마커를 추가
  // void _addGymwayMarker() {
  //   if (_mapController != null) {
  //     final marker = NMarker(
  //       id: 'gymway', // 마커 고유 ID
  //       position: _gymwayLocation, // 짐웨이 좌표
  //       caption: NOverlayCaption(text: _gymwayName), // 마커 이름
  //       // 추가적인 마커 설정 (예: 아이콘, 캡션 스타일 등)
  //       icon: const NOverlayImage.fromAssetImage(
  //           'assets/marker_icon.png'), // 예시 아이콘 (직접 추가해야 함)
  //       // size: Size(30, 40), // 마커 크기 조정
  //     );

  //     _mapController!.addOverlay(marker); // 지도에 마커 추가

  //     // 마커 탭 리스너 추가 (선택 사항)
  //     marker.setOnTapListener((overlay) {
  //       debugPrint("$_gymwayName 마커 탭됨!");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('$_gymwayName 마커를 탭했습니다!')),
  //       );
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    // widget.locationData?가 null일 경우 기본값으로 서울 시청을 사용합니다.
    // 지도의 초기 위치는 이 값을 따릅니다.
    final NLatLng initialTarget = NLatLng(
      widget.locationData?.latitude ?? 37.5665, // 현재 위치가 없으면 서울 시청 위도
      widget.locationData?.longitude ?? 126.9780, // 현재 위치가 없으면 서울 시청 경도
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SPORY',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
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
                        if (widget.locationData! != null) {
                          _updateLocationOverlay(widget.locationData!);
                          // 지도의 카메라를 현재 위치로 이동시킵니다.
                          _mapController!.updateCamera(
                            NCameraUpdate.fromCameraPosition(
                              NCameraPosition(
                                target: NLatLng(
                                  widget.locationData!.latitude!,
                                  widget.locationData!.longitude!,
                                ),
                                zoom: 15,
                              ),
                            ),
                          );
                        }
                        // _addGymwayMarker();
                      },
                    ),
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
