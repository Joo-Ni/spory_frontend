import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    // Size screenSize = MediaQuery.of(context).size;
    // double width = screenSize.width;
    // double height = screenSize.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('스포츠 커넥트'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xFFF5F5F5)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
