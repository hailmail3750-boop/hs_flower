import 'package:flutter/material.dart';
import 'builder_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const blue = Color(0xFF4674C3);
  static const gray = Color(0xFFAFAFAF);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = '꽃';
  String? selectedItem;
  Map<String, int> colorQuantities = {};

  final Map<String, List<String>> categoryItems = {
    '꽃': ['장미\n그림', '해바라기\n그림', '카네이션\n그림', '튤립\n그림'],
    '필러': ['안개꽃\n그림', '수국\n그림', '유칼립투스\n그림', '라그라스\n그림'],
    '포장지': ['빨간색\n그림', '초록색\n그림', '분홍색\n그림', '흰색\n그림'],
    '리본': ['빨간 리본\n그림', '흰 리본\n그림', '금색 리본\n그림'],
    '문구': ['생일축하\n문구', '사랑해\n문구', '감사해\n문구'],
  };

  final Map<String, List<String>> itemColors = {
    '장미\n그림': ['빨간장미 그림', '노란장미 그림', '주황장미 그림', '분홍장미 그림'],
    '해바라기\n그림': ['노란해바라기 그림', '주황해바라기 그림'],
    '카네이션\n그림': ['빨간카네이션 그림', '분홍카네이션 그림', '흰카네이션 그림'],
    '튤립\n그림': ['빨간튤립 그림', '노란튤립 그림', '분홍튤립 그림'],
    '안개꽃\n그림': ['하얀안개꽃 그림', '파란안개꽃 그림', '분홍안개꽃 그림'],
    '수국\n그림': ['파란수국 그림', '분홍수국 그림', '흰수국 그림'],
    '유칼립투스\n그림': ['초록유칼립투스 그림'],
    '라그라스\n그림': ['베이지라그라스 그림'],
    '빨간색\n그림': ['빨간색 포장지'],
    '초록색\n그림': ['초록색 포장지'],
    '분홍색\n그림': ['분홍색 포장지'],
    '흰색\n그림': ['흰색 포장지'],
    '빨간 리본\n그림': ['빨간 리본'],
    '흰 리본\n그림': ['흰 리본'],
    '금색 리본\n그림': ['금색 리본'],
    '생일축하\n문구': ['생일축하'],
    '사랑해\n문구': ['사랑해'],
    '감사해\n문구': ['감사해'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 600,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 30),

                Container(
                  width: 515,
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '🔎 #사랑 #우정 #행복 #기념일',
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  width: 515,
                  height: 212,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 36,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: categoryItems.keys.map((category) {
                            return CategoryButton(
                              text: category,
                              isSelected: selectedCategory == category,
                              onTap: () {
                                setState(() {
                                  selectedCategory = category;
                                  selectedItem = null;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                                categoryItems[selectedCategory]!.map((item) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedItem = item;
                                  });
                                },
                                child: FlowerBox(
                                  text: item,
                                  isSelected: selectedItem == item,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                Container(
                  width: 140,
                  height: 24,
                  alignment: Alignment.center,
                  color: HomeScreen.blue,
                  child: const Text(
                    '상세 옵션',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  width: 510,
                  constraints: const BoxConstraints(minHeight: 80),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: selectedItem == null || !itemColors.containsKey(selectedItem)
                      ? Center(
                          child: Text(
                            '꽃을 선택해주세요',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[400],
                            ),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...itemColors[selectedItem]!
                                .asMap()
                                .entries
                                .map((entry) {
                              final colorName = entry.value;
                              final isLast =
                                  entry.key == itemColors[selectedItem]!.length - 1;
                              return Column(
                                children: [
                                  ColorRow(
                                    text: colorName,
                                    quantity: colorQuantities[colorName] ?? 0,
                                    onPlus: () {
                                      setState(() {
                                        colorQuantities[colorName] =
                                            (colorQuantities[colorName] ?? 0) + 1;
                                      });
                                    },
                                    onMinus: () {
                                      setState(() {
                                        final current =
                                            colorQuantities[colorName] ?? 0;
                                        if (current > 0) {
                                          colorQuantities[colorName] =
                                              current - 1;
                                        }
                                      });
                                    },
                                  ),
                                  if (!isLast)
                                    const SizedBox(height: 10),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                ),

                const Spacer(),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 34),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: HomeScreen.blue,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '장바구니\n아이콘\n(수량)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Container(
                  height: 54,
                  color: HomeScreen.gray,
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BottomButton(text: '오늘의 꽃'),
                      BottomButton(
                        text: 'Home',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BuilderScreen(),
                            ),
                          );
                        },
                      ),
                      const BottomButton(text: 'My page'),
                      const BottomButton(text: '⚙'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryButton({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 24,
        alignment: Alignment.center,
        color: isSelected ? HomeScreen.blue : HomeScreen.gray,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class FlowerBox extends StatelessWidget {
  final String text;
  final Color color;
  final bool isSelected;

  const FlowerBox({
    super.key,
    required this.text,
    this.color = HomeScreen.blue,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 128,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? HomeScreen.blue : Colors.grey[300],
        border: isSelected ? Border.all(color: HomeScreen.blue, width: 3) : null,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 17,
        ),
      ),
    );
  }
}

class ColorRow extends StatelessWidget {
  final String text;
  final int quantity;
  final VoidCallback? onPlus;
  final VoidCallback? onMinus;

  const ColorRow({
    super.key,
    required this.text,
    this.quantity = 0,
    this.onPlus,
    this.onMinus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 188,
          height: 52,
          alignment: Alignment.center,
          color: HomeScreen.blue,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        const SizedBox(width: 18),
        SmallButton(text: '-', onTap: onMinus),
        const SizedBox(width: 6),
        SmallButton(text: '${quantity}EA', width: 55),
        const SizedBox(width: 6),
        SmallButton(text: '+', onTap: onPlus),
      ],
    );
  }
}

class SmallButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback? onTap;

  const SmallButton({
    super.key,
    required this.text,
    this.width = 24,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 25,
        alignment: Alignment.center,
        color: HomeScreen.blue,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const BottomButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: text == '⚙' ? 45 : 92,
        height: 48,
        alignment: Alignment.center,
        color: HomeScreen.blue,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}