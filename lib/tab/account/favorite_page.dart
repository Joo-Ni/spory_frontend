// lib/tab/account/favorite_page.dart
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  final List<Map<String, String>> favoriteFacilities;

  const FavoritePage({super.key, required this.favoriteFacilities});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late List<Map<String, String>> _currentFavoriteFacilities;

  @override
  void initState() {
    super.initState();
    _currentFavoriteFacilities = List.from(widget.favoriteFacilities);
  }

  void _toggleFavorite(String facilityName) {
    setState(() {
      final index = _currentFavoriteFacilities
          .indexWhere((f) => f['name'] == facilityName);
      if (index != -1) {
        _currentFavoriteFacilities.removeAt(index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$facilityName 즐겨찾기에서 해제됨')),
        );
      } else {
        // (이 페이지에서는 발생하지 않겠지만) 만약 없는 항목을 다시 추가한다면
        // SearchPage의 데이터를 가져와야 합니다. 여기서는 간략하게 처리.
        // 예를 들어, 실제 앱에서는 DB에서 해당 항목을 찾아 다시 추가하는 로직이 필요합니다.
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('$facilityName 즐겨찾기에 다시 추가됨 (미구현)')),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '즐겨찾기 목록',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: _currentFavoriteFacilities.isEmpty
          ? const Center(child: Text('즐겨찾기한 시설이 없습니다.'))
          : ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: _currentFavoriteFacilities.length,
              itemBuilder: (context, index) {
                final facility = _currentFavoriteFacilities[index];
                final facilityName = facility['name']!;

                final bool isFavorite = true;

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${facilityName} 상세 정보')),
                        );
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
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
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
                            IconButton(
                              icon: Icon(
                                isFavorite ? Icons.star : Icons.star_border,
                                color: isFavorite ? Colors.amber : Colors.grey,
                                size: 30,
                              ),
                              onPressed: () {
                                _toggleFavorite(facilityName);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (index < _currentFavoriteFacilities.length - 1)
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
