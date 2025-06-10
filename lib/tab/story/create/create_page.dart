import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
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
              primary: Color.fromARGB(255, 43, 180, 153),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
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
    final String title = _titleController.text;
    final String content = _contentController.text;
    final String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

    if (title.isNotEmpty && content.isNotEmpty) {
      print('Journal Date: $formattedDate');
      print('Journal Title: $title');
      print('Journal Content: $content');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('일지 (날짜: $formattedDate)가 저장되었습니다!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('제목과 내용을 모두 입력해주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spory'),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // 날짜 선택 버튼
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

            // 제목 입력 필드
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: '일지 제목을 입력하세요.',
                hintStyle: TextStyle(color: Colors.grey[600]),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              maxLength: 100,
            ),

            const Divider(
              color: Colors.grey, // 선 색상
              thickness: 0.8, // 선 두께
              height: 20, // 위젯 사이의 총 높이 (선 자체 두께 + 위아래 여백)
              indent: 0, // 시작 부분 들여쓰기
              endIndent: 0, // 끝 부분 들여쓰기
            ),

            //const SizedBox(height: 10),

            SizedBox(
              height: 550,
              child: SingleChildScrollView(
                child: TextField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    hintText: '오늘의 활동, 생각, 느낌을 기록하세요.',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  ),
                  maxLength: 2000,
                  keyboardType: TextInputType.multiline,
                  minLines: null, // minLines와 maxLines를 null로 유지 (이전 문제 해결 방식)
                  maxLines: null, // null로 두면 SingleChildScrollView 내에서 내용만큼 늘어남
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ),
            const SizedBox(height: 5), // 이 공간은 이제 내용 필드의 높이로 조절되므로 필요 없음

            // 저장 버튼
            ElevatedButton(
              onPressed: _saveJournalEntry,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(180, 50),
                backgroundColor: Color.fromARGB(255, 43, 180, 153),
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
