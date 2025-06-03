import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(height: 20),
        // TextField(
        //   decoration: InputDecoration(
        //       filled: true,
        //       hintStyle: TextStyle(color: Colors.grey[800]),
        //       hintText: "이곳에 내용을 입력하세요.",
        //       fillColor: Colors.white),
        //   minLines: 1,
        //   maxLines: 15,
        //   maxLength: 420,
        //   // ✅ 글자 수 제한
        //   keyboardType: TextInputType.multiline,
        // ),
      ),
    );
  }
}
