import 'package:flutter/material.dart';
import 'builder_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const blue = Color(0xFF4674C3);
  static const gray = Color(0xFFAFAFAF);

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
                const SizedBox(height: 15),

                // Title
                Container(
                  width: 390,
                  height: 44,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: const Text(
                    '나만의 꽃 만들기',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                ),

                const SizedBox(height: 15),

                // Search
                Container(
                  width: 515,
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '🔎 Search',
                    style: TextStyle(fontSize: 17),
                  ),
                ),

                const SizedBox(height: 30),

                // Category + flower images
                Container(
                  width: 515,
                  height: 212,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 36,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            CategoryButton(text: '꽃'),
                            CategoryButton(text: '필러'),
                            CategoryButton(text: '포장지'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              FlowerBox(text: '장미\n그림', color: gray),
                              FlowerBox(text: '해바라기\n그림'),
                              FlowerBox(text: '카네이션\n그림'),
                              FlowerBox(text: '튤립\n그림'),
                            ],
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
                  color: blue,
                  child: const Text(
                    '꽃 색상',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                const SizedBox(height: 6),

                // Color options
                Container(
                  width: 510,
                  height: 213,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: const [
                      ColorRow(text: '빨간장미 그림'),
                      SizedBox(height: 10),
                      ColorRow(text: '노란장미 그림'),
                      SizedBox(height: 10),
                      ColorRow(text: '주황장미 그림'),
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
                        color: blue,
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

                // Bottom navigation
                Container(
                  height: 54,
                  color: gray,
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

  const CategoryButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 24,
      alignment: Alignment.center,
      color: HomeScreen.blue,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

class FlowerBox extends StatelessWidget {
  final String text;
  final Color color;

  const FlowerBox({
    super.key,
    required this.text,
    this.color = HomeScreen.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 128,
      alignment: Alignment.center,
      color: color,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 17),
      ),
    );
  }
}

class ColorRow extends StatelessWidget {
  final String text;

  const ColorRow({super.key, required this.text});

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
        const SmallButton(text: '-'),
        const SizedBox(width: 6),
        const SmallButton(text: '~EA', width: 55),
        const SizedBox(width: 6),
        const SmallButton(text: '+'),
      ],
    );
  }
}

class SmallButton extends StatelessWidget {
  final String text;
  final double width;

  const SmallButton({
    super.key,
    required this.text,
    this.width = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 25,
      alignment: Alignment.center,
      color: HomeScreen.blue,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 15),
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