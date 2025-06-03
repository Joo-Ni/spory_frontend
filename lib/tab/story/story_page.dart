import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // table_calendar 임포트

import '../../create/create_page.dart'; // CreatePage가 있다고 가정

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  // true면 캘린더 (왼쪽), false면 리스트 (오른쪽)
  bool _showCalendar = true;

  // table_calendar 관련 상태 변수
  CalendarFormat _calendarFormat = CalendarFormat.month; // 캘린더 초기 형식
  DateTime _focusedDay = DateTime.now(); // 캘린더가 현재 포커스하는 날짜
  DateTime? _selectedDay; // 사용자가 선택한 날짜

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePage()),
          );
        },
        backgroundColor: Color.fromARGB(255, 43, 180, 153),
        child: Icon(Icons.create),
      ),
      appBar: AppBar(
        title: const Text('Spory'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // bottom 위젯의 높이
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0), // 하단에 약간의 여백 추가
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // 배경색
                borderRadius: BorderRadius.circular(16.0), // 둥근 모서리
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Row의 크기를 자식 위젯에 맞춥니다.
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showCalendar = true;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: _showCalendar
                            ? Color.fromARGB(255, 43, 180, 153)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        '캘린더',
                        style: TextStyle(
                          color: _showCalendar ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showCalendar = false;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: !_showCalendar
                            ? Color.fromARGB(255, 43, 180, 153)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        '리스트',
                        style: TextStyle(
                          color: !_showCalendar ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: _showCalendar
            ? _buildCalendarView() // 캘린더 뷰
            : _buildListView(), // 리스트 뷰
      ),
    );
  }

  // 캘린더 뷰를 나타내는 위젯
  Widget _buildCalendarView() {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 1, 1), // 캘린더의 시작 날짜
          lastDay: DateTime.utc(2040, 12, 31), // 캘린더의 마지막 날짜
          focusedDay: _focusedDay, // 현재 포커스된 날짜
          calendarFormat: _calendarFormat, // 캘린더 형식 (월, 주 등)
          selectedDayPredicate: (day) {
            // `_selectedDay`와 동일한 날짜인지 확인하여 선택된 날짜를 강조
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            // 날짜가 선택되었을 때 호출됩니다.
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // 선택된 날짜로 포커스 변경
              });
            }
          },
          onFormatChanged: (format) {
            // 캘린더 형식이 변경되었을 때 호출됩니다.
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            // 캘린더 페이지가 변경되었을 때 (월이 변경될 때) 호출됩니다.
            _focusedDay = focusedDay;
          },
          // 캘린더 UI 스타일 설정 (선택 사항)
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false, // 현재 월이 아닌 날짜를 숨길지 여부
            selectedDecoration: BoxDecoration(
              // 선택된 날짜의 데코레이션
              color: Color.fromARGB(255, 43, 180, 153),
              shape: BoxShape.circle,
            ),
            selectedTextStyle:
                TextStyle(color: Colors.white), // 선택된 날짜의 텍스트 스타일
            todayDecoration: BoxDecoration(
              // 오늘 날짜의 데코레이션
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false, // 형식 변경 버튼 숨기기 (월, 주 등)
            titleCentered: true, // 헤더 타이틀 중앙 정렬
          ),
        ),
        // 선택된 날짜에 대한 추가 정보 또는 이벤트를 표시할 수 있는 공간
        Expanded(
          child: Center(
            child: _selectedDay != null
                ? Text(
                    '선택된 날짜: ${_selectedDay!.toLocal().toString().split(' ')[0]}')
                : Text('날짜를 선택해주세요.'),
          ),
        ),
      ],
    );
  }

  // 리스트 뷰를 나타내는 위젯
  Widget _buildListView() {
    return ListView(
      children: const [
        ListTile(title: Text('항목 1')),
        ListTile(title: Text('항목 2')),
        ListTile(title: Text('항목 3')),
        ListTile(title: Text('항목 4')),
        ListTile(title: Text('항목 5')),
      ],
    );
  }
}
