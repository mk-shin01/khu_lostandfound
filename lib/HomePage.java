import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _dummyData = ['에어팟', '헤드셋', '할머니']; // 더미 데이터
  List<String> _filteredData = []; // 검색 결과 데이터

  @override
  void initState() {
    super.initState();
    _filteredData = _dummyData; // 초기에는 모든 데이터 표시
    _searchController.addListener(_onSearchChanged); // 검색 텍스트 변경 리스너
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      // 검색 텍스트를 포함하는 값만 필터링
      _filteredData = _dummyData
          .where((item) => item.contains(_searchController.text))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '검색 페이지',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 4.0,
                color: Colors.black45,
                offset: Offset(1.5, 1.5),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.red[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredData.isEmpty
                  ? const Center(
                      child: Text(
                        '결과가 없습니다.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredData.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.search, color: Colors.grey),
                          title: Text(
                            _filteredData[index],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            // 아이템 클릭 시 추가 동작
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('선택한 항목'),
                                content: Text(_filteredData[index]),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('닫기'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
