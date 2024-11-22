import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<String> categories = ['전화기', '순대', '에어팟'];
  final List<Map<String, dynamic>> items = [
    {'image': 'assets/1.png', 'category': '전화기'},
    {'image': 'assets/1.png', 'category': '에어팟'},
    {'image': 'assets/1.png', 'category': '순대'},
  ];

  List<bool> selectedCategories = [false, false, false];
  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = items;
  }

  void _filterItems() {
    setState(() {
      final selectedCategory = categories
          .asMap()
          .entries
          .where((entry) => selectedCategories[entry.key])
          .map((entry) => entry.value)
          .toList();

      if (selectedCategory.isEmpty) {
        filteredItems = items;
      } else {
        filteredItems = items
            .where((item) => selectedCategory.contains(item['category']))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '카테고리',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: ToggleButtons(
              isSelected: selectedCategories,
              onPressed: (index) {
                setState(() {
                  selectedCategories[index] = !selectedCategories[index];
                  _filterItems();
                });
              },
              borderRadius: BorderRadius.circular(8),
              selectedColor: Colors.white,
              fillColor: Colors.deepPurple,
              borderColor: Colors.grey,
              selectedBorderColor: Colors.deepPurple,
              children: categories
                  .map(
                    (category) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    category,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Stack(
                    children: [
                      // 이미지 컨테이너
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                          image: DecorationImage(
                            image: AssetImage(item['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Positioned(
                        top: 10,
                        right: 10,
                        child: ElevatedButton(
                          onPressed: () {
                            print('${item['category']} 수정 클릭');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('수정'),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: ElevatedButton(
                          onPressed: () {
                            print('${item['category']} 삭제 클릭');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('삭제'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
