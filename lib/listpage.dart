import 'package:flutter/material.dart';


// 새로운 목록 페이지
class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '목록 페이지',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red[800],
      ),
      body: const Center(
        child: Text(
          '여기에 목록 데이터를 표시하세요.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}