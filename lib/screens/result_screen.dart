import 'package:flutter/material.dart';
import '../models/bouquet_option.dart';

class ResultScreen extends StatelessWidget {
  final BouquetOption option;

  const ResultScreen({
    super.key,
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    final prompt = option.toPrompt();

    return Scaffold(
      appBar: AppBar(
        title: const Text('생성 프롬프트'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '선택한 조건',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text('꽃 종류: ${option.flowerType}'),
            Text('꽃 색상: ${option.flowerColor}'),
            Text('꽃 개수: ${option.quantity}'),
            Text('필러: ${option.filler}'),
            Text('포장지: ${option.wrappingColor}'),

            const SizedBox(height: 24),

            const Text(
              'AI 이미지 생성용 프롬프트',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(prompt),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 나중에 이미지 생성 API 연결
                },
                child: const Text('AI 이미지 생성하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}