import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _hourController =
      TextEditingController(); // 시간 입력 컨트롤러
  final TextEditingController _minuteController =
      TextEditingController(); // 분 입력 컨트롤러

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // 초기값 설정 (옵션: 0으로 시작)
    _hourController.text = '0';
    _minuteController.text = '0';
  }

  @override
  void dispose() {
    _contentController.dispose();
    _hourController.dispose(); // 컨트롤러 해제
    _minuteController.dispose(); // 컨트롤러 해제
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: '일지 날짜 선택',
      cancelText: '취소',
      confirmText: '선택',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color.fromARGB(255, 43, 180, 153),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogTheme: const DialogTheme(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveJournalEntry() {
    final String content = _contentController.text;
    final String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

    // 입력된 시간과 분을 정수로 파싱, 유효하지 않으면 0으로 처리
    final int hour = int.tryParse(_hourController.text) ?? 0;
    final int minute = int.tryParse(_minuteController.text) ?? 0;

    // 시간/분 범위 유효성 검사 (0-10시간, 0-59분)
    if (hour < 0 || hour > 10 || minute < 0 || minute > 59) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('유효한 운동 시간을 입력해주세요 (0~10시간, 0~59분).')),
      );
      return; // 유효성 검사 실패 시 저장 중단
    }

    final String formattedExerciseTime = '${hour}시간 ${minute}분';

    if (content.isNotEmpty) {
      print('Journal Date: $formattedDate');
      print('Exercise Time: $formattedExerciseTime');
      print('Journal Content: $content');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '일지 (날짜: $formattedDate, 운동 시간: $formattedExerciseTime)가 저장되었습니다!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('내용을 입력해주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // 날짜 선택 버튼 (기존과 동일)
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '일지 날짜: ${DateFormat('yyyy년 MM월 dd일').format(_selectedDate)}',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    Icon(Icons.calendar_today,
                        size: 18, color: Theme.of(context).colorScheme.primary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // 운동 시간 입력 필드 (직접 입력, 흰 배경 사각형)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.symmetric(vertical: 8), // 상하 여백
              decoration: BoxDecoration(
                color: Colors.white, // 흰색 배경
                borderRadius: BorderRadius.circular(10.0), // 둥근 모서리
                border: Border.all(
                  color: Colors.grey.shade300, // 연한 회색 테두리
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '운동 시간:',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 50, // 시간 입력 필드 너비
                    child: TextField(
                      controller: _hourController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        isDense: true, // 내부 패딩을 줄여 공간 절약
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none, // 기본 테두리 없음
                        hintText: '0',
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Text('시간',
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 50, // 분 입력 필드 너비
                    child: TextField(
                      controller: _minuteController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: '0',
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Text('분',
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.8,
              height: 20,
              indent: 0,
              endIndent: 0,
            ),

            // 운동 내용 입력 필드 (흰 배경 사각형)
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white, // 흰색 배경
                  borderRadius: BorderRadius.circular(10.0), // 둥근 모서리
                  border: Border.all(
                    color: Colors.grey.shade300, // 연한 회색 테두리
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      hintText: '오늘의 활동, 생각, 느낌을 기록하세요.',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero, // 컨테이너 패딩으로 충분
                    ),
                    maxLength: 2000,
                    keyboardType: TextInputType.multiline,
                    minLines: null,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 저장 버튼
            ElevatedButton(
              onPressed: _saveJournalEntry,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(180, 50),
                backgroundColor: const Color.fromARGB(255, 43, 180, 153),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                '저장하기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
