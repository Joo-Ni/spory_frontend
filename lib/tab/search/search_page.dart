// lib/tab/category/search_page.dart
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final String selectedCategory; // 선택된 카테고리를 받을 변수

  const SearchPage({super.key, required this.selectedCategory});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Map<String, bool> _favoriteStates = {};

  // 임시 시설물 데이터 (이미지 경로, 이름, 지역 포함)
  List<Map<String, String>> _getFacilitiesForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'pt':
        return [
          {
            'image': 'assets/images/gym_example.png',
            'name': '헬스장1',
            'location': '경기도 용인시 ..'
          },
          {
            'image': 'assets/images/gym_example2.png',
            'name': '강남 PT 스튜디오',
            'location': '서울특별시 강남구 ..'
          },
          {
            'image': 'assets/images/gym_example3.png',
            'name': '판교 프리미엄 짐',
            'location': '경기도 성남시 분당구 ..'
          },
        ];
      case '배드민턴':
        return [
          {
            'image': 'assets/images/badminton_example.png',
            'name': '배드민턴장1',
            'location': '경기도 용인시 ..'
          },
          {
            'image': 'assets/images/badminton_example2.png',
            'name': '서울 배드민턴 클럽',
            'location': '서울특별시 송파구 ..'
          },
          {
            'image': 'assets/images/badminton_example3.png',
            'name': '성남시 배드민턴장',
            'location': '경기도 성남시 ..'
          },
        ];
      case '수영':
        return [
          {
            'image': 'assets/images/swimming_example.png',
            'name': '올림픽 수영장',
            'location': '서울특별시 송파구 ..'
          },
          {
            'image': 'assets/images/swimming_example2.png',
            'name': '수원 실내 수영장',
            'location': '경기도 수원시 ..'
          },
        ];
      case '테니스':
        return [
          {
            'image': 'assets/images/tennis_example.png',
            'name': '잠실 테니스장',
            'location': '서울특별시 송파구 ..'
          },
          {
            'image': 'assets/images/tennis_example2.png',
            'name': '안양 테니스 코트',
            'location': '경기도 안양시 ..'
          },
        ];
      case '축구':
        return [
          {
            'image': 'assets/images/soccer_example.png',
            'name': '상암 월드컵 경기장',
            'location': '서울특별시 마포구 ..'
          },
          {
            'image': 'assets/images/soccer_example2.png',
            'name': '탄천 종합운동장 축구장',
            'location': '경기도 성남시 ..'
          },
        ];
      case '요가':
        return [
          {
            'image': 'assets/images/yoga_example.png',
            'name': '요가 센터1',
            'location': '경기도 용인시 ..'
          },
          {
            'image': 'assets/images/yoga_example2.png',
            'name': '강남 요가 스튜디오',
            'location': '서울특별시 강남구 ..'
          },
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> facilities =
        _getFacilitiesForCategory(widget.selectedCategory);

    for (var facility in facilities) {
      if (!_favoriteStates.containsKey(facility['name'])) {
        _favoriteStates[facility['name']!] = false; // 기본값은 비활성화(회색)
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.selectedCategory} 시설 목록',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: facilities.isEmpty
          ? const Center(child: Text('해당 카테고리의 시설을 찾을 수 없습니다.'))
          : ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: facilities.length,
              itemBuilder: (context, index) {
                final facility = facilities[index];
                final facilityName = facility['name']!; // null 아님을 보장

                // 현재 시설의 즐겨찾기 상태 가져오기
                final bool isFavorite = _favoriteStates[facilityName] ?? false;

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${facilityName} 선택됨!')),
                        );
                        // TODO: 상세 페이지로 이동 로직 추가 (별 아이콘 탭과는 별개)
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                facility['image'] ??
                                    'assets/images/default_placeholder.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey[200],
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.grey[400]),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    facilityName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    facility['location'] ?? '위치 정보 없음',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 별 아이콘 추가
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.star
                                    : Icons.star_border, // 상태에 따라 아이콘 변경
                                color: isFavorite
                                    ? Colors.amber
                                    : Colors.grey, // 상태에 따라 색상 변경
                                size: 30, // 아이콘 크기
                              ),
                              onPressed: () {
                                setState(() {
                                  // 즐겨찾기 상태 토글
                                  _favoriteStates[facilityName] = !isFavorite;
                                });
                                // 사용자에게 피드백 제공 (선택 사항)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isFavorite
                                          ? '${facilityName} 즐겨찾기 해제됨'
                                          : '${facilityName} 즐겨찾기에 추가됨',
                                    ),
                                    duration: const Duration(milliseconds: 700),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (index < facilities.length - 1)
                      const Divider(
                        height: 1,
                        thickness: 1,
                        indent: 12,
                        endIndent: 12,
                        color: Colors.grey,
                      ),
                  ],
                );
              },
            ),
    );
  }
}
