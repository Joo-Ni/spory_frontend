import 'package:flutter/material.dart';
import 'package:sports_connect/tab/search/search_page.dart'; // SearchPage 임포트

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
// 검색될 종목 리스트 예 (SearchAnchor용)
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
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size; // 사용되지 않으므로 제거
    // double width = screenSize.width; // 사용되지 않으므로 제거
    // double height = screenSize.height; // 사용되지 않으므로 제거

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
                /////////// 사용자 입력에 따라 추천 목록을 생성 //////////
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
                          // 검색 결과로 SearchPage로 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchPage(selectedCategory: suggestion),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                ///////////// 추천 목록 /////////////////
              ),
              const Padding(
                padding: EdgeInsets.all(8),
              ),
              Expanded(
                child: ListView(
                  children: [
                    // 각 ListTile을 탭하면 SearchPage로 이동하며 해당 카테고리 전달
                    _buildCategoryTile('PT'),
                    _buildCategoryTile('배드민턴'),
                    _buildCategoryTile('수영'),
                    _buildCategoryTile('테니스'),
                    _buildCategoryTile('축구'),
                    // 필요하다면 더 많은 카테고리 추가
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 카테고리 ListTile을 생성하는 헬퍼 함수
  Widget _buildCategoryTile(String categoryName) {
    return ListTile(
      title: Text(categoryName),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(selectedCategory: categoryName),
          ),
        );
      },
    );
  }
}
