import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // table_calendar 임포트

import 'create/create_page.dart'; // CreatePage가 있다고 가정

// 더미 스토리 데이터를 위한 클래스
class StoryEntry {
  final String date;
  final String exerciseTime;
  final String exerciseDetails;
  final DateTime dateTime; // 캘린더 연동을 위해 DateTime 객체 추가

  StoryEntry({
    required this.date,
    required this.exerciseTime,
    required this.exerciseDetails,
    required this.dateTime, // 생성자에 추가
  });
}

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  bool _showCalendar = true; // true면 캘린더 (왼쪽), false면 리스트 (오른쪽)

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // 선택된 날짜에 해당하는 운동 기록 리스트
  List<StoryEntry> _selectedDayEvents = [];

  // 이미지에서 보인 형식에 맞춰 더미 데이터 생성
  // DateTime 객체를 사용하여 날짜를 더 정확하게 표현합니다.
  final List<StoryEntry> _storyEntries = [
    StoryEntry(
      date: '05/31',
      exerciseTime: '2시간',
      exerciseDetails: '배드민턴',
      dateTime: DateTime.utc(2025, 5, 31),
    ),
    StoryEntry(
      date: '05/12',
      exerciseTime: '40분',
      exerciseDetails: '러닝',
      dateTime: DateTime.utc(2025, 5, 12),
    ),
    StoryEntry(
      date: '05/23',
      exerciseTime: '1시간 28분',
      exerciseDetails: '클라이밍',
      dateTime: DateTime.utc(2025, 5, 23),
    ),
    StoryEntry(
      date: '04/17',
      exerciseTime: '52분',
      exerciseDetails: 'PT',
      dateTime: DateTime.utc(2025, 4, 17),
    ),
    StoryEntry(
      date: '04/06',
      exerciseTime: '40분',
      exerciseDetails: '러닝',
      dateTime: DateTime.utc(2025, 4, 6),
    ),
    StoryEntry(
      date: '04/02',
      exerciseTime: '1시간 20분',
      exerciseDetails: '러닝',
      dateTime: DateTime.utc(2025, 4, 2),
    ),
    StoryEntry(
      date: '03/31',
      exerciseTime: '1시간 4분',
      exerciseDetails: '배드민턴을 쳤다',
      dateTime: DateTime.utc(2025, 3, 31),
    ),
  ];

  final ScrollController _listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedDayEvents = _getEventsForDay(_selectedDay!);
  }

  // 특정 날짜에 해당하는 이벤트를 반환하는 함수
  List<StoryEntry> _getEventsForDay(DateTime day) {
    return _storyEntries
        .where((entry) => isSameDay(entry.dateTime, day))
        .toList();
  }

  // 캘린더에서 날짜 선택 시 호출되는 함수
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedDayEvents = _getEventsForDay(selectedDay);
      });
    }
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    super.dispose();
  }

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
        backgroundColor: const Color.fromARGB(255, 43, 180, 153),
        shape: const CircleBorder(),
        child: const Icon(Icons.create),
      ),
      appBar: AppBar(
        title: const Text(
          'SPORY',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showCalendar = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: _showCalendar
                            ? const Color.fromARGB(255, 43, 180, 153)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(18.0),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: !_showCalendar
                            ? const Color.fromARGB(255, 43, 180, 153)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(18.0),
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
        child: _showCalendar ? _buildCalendarView() : _buildListView(),
      ),
    );
  }

  // 캘린더 뷰를 나타내는 위젯
  Widget _buildCalendarView() {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 1, 1),
          lastDay: DateTime.utc(2040, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: _onDaySelected,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          eventLoader: _getEventsForDay,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            selectedDecoration: BoxDecoration(
              color: const Color.fromARGB(255, 43, 180, 153),
              shape: BoxShape.circle,
            ),
            selectedTextStyle: const TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
            markerDecoration: const BoxDecoration(
              color: Color.fromARGB(255, 43, 180, 153),
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        ),
        const SizedBox(height: 16.0), // 캘린더와 운동 일지 섹션 간의 간격
        Expanded(
          // 이 부분을 Container로 감싸고 스타일을 적용합니다.
          child: Container(
            margin: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0), // 좌우 여백
            padding: const EdgeInsets.all(16.0), // 내부 여백
            decoration: BoxDecoration(
              color: Colors.white, // 배경색을 흰색으로
              borderRadius: BorderRadius.circular(15.0), // 둥근 모서리
              border: Border.all(
                color: Color.fromARGB(255, 43, 180, 153)
                    .withOpacity(0.5), // 테두리 색상
                width: 1.0,
              ),
              boxShadow: [
                // 그림자 추가 (선택 사항)
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: _selectedDayEvents.isEmpty
                ? const Center(child: Text('선택된 날짜에 운동 기록이 없습니다.'))
                : ListView.builder(
                    itemCount: _selectedDayEvents.length,
                    itemBuilder: (context, index) {
                      final entry = _selectedDayEvents[index];
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 8.0), // 세로 간격
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '운동 시간: ${entry.exerciseTime}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              entry.exerciseDetails,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  // 리스트 뷰를 나타내는 위젯
  Widget _buildListView() {
    return Scrollbar(
      controller: _listScrollController,
      thickness: 8.0,
      radius: const Radius.circular(10.0),
      interactive: true,
      child: ListView.builder(
        controller: _listScrollController,
        padding: const EdgeInsets.all(18.0),
        itemCount: _storyEntries.length,
        itemBuilder: (context, index) {
          final entry = _storyEntries[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.date,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '운동 시간 : ${entry.exerciseTime}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.exerciseDetails,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
