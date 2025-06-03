import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
// 검색될 종목 리스트 예
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
    Size screenSize = MediaQuery.of(context).size;
    // double width = screenSize.width; // 사용되지 않으므로 제거 가능
    // double height = screenSize.height; // 사용되지 않으므로 제거 가능

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Spory'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          // SingleChildScrollView 제거하고 Column을 직접 body의 자식으로 사용합니다.
          child: Column(
            children: [
              SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    backgroundColor: WidgetStateProperty.all(Color(0xFFF5F5F5)),
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
                  children: const [
                    ListTile(title: Text('항목 1')),
                    ListTile(title: Text('항목 2')),
                    ListTile(title: Text('항목 3')),
                    ListTile(title: Text('항목 4')),
                    ListTile(title: Text('항목 5')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
