import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../tab/tab_page.dart';

class AuthGate extends StatefulWidget {
  final LocationData? locationData;

  const AuthGate({Key? key, this.locationData}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 백엔드 연결 후 로그인 여부에 따라 다른 페이지로 이동 (예: 로그인 페이지 또는 TabPage)
    // 현재는 임시로 UI를 보여주고 "Continue" 버튼을 누르면 TabPage로 이동합니다.

    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar 배경색도 흰색으로 설정
        elevation: 0, // AppBar 그림자 제거
        title: const Text(
          'SPORY',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                '계정을 생성하세요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '계정을 생성하려면 이메일을 입력하세요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'email@domain.com',
                  fillColor: Color(0xFFF5F5F5), // 배경색
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none, // 테두리 없음
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true, // 비밀번호 숨김 처리
                decoration: InputDecoration(
                  hintText: 'password',
                  fillColor: Color(0xFFF5F5F5), // 배경색
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none, // 테두리 없음
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // TODO: 백엔드 로그인/회원가입 로직 추가
                  // 현재는 버튼 누르면 TabPage로 이동
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          TabPage(locationData: widget.locationData),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2BB399), // 버튼 배경색
                  foregroundColor: Colors.white, // 버튼 텍스트 색상
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0, // 버튼 그림자 제거
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
