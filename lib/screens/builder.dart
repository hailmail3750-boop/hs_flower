import 'package:flutter/material.dart';
import '../models/bouquet_option.dart';
import 'result.dart';

class BuilderScreen extends StatefulWidget {
  const BuilderScreen({super.key});

  @override
  State<BuilderScreen> createState() => _BuilderScreenState();
}

class _BuilderScreenState extends State<BuilderScreen> {
  String flowerType = 'Rose';
  String flowerColor = 'Pink';
  int quantity = 5;
  String filler = 'Baby\'s Breath';
  String wrappingColor = 'White & Pink';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('꽃다발 옵션 선택'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDropdown(
              title: '꽃 종류',
              value: flowerType,
              items: ['Rose', 'Tulip', 'Lily', 'Carnation'],
              onChanged: (value) {
                setState(() {
                  flowerType = value!;
                });
              },
            ),

            _buildDropdown(
              title: '꽃 색상',
              value: flowerColor,
              items: ['Pink', 'Red', 'White', 'Yellow', 'Purple'],
              onChanged: (value) {
                setState(() {
                  flowerColor = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('꽃 개수', style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      onPressed: quantity > 1
                          ? () {
                              setState(() {
                                quantity--;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.remove),
                    ),
                    Text('$quantity'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),

            _buildDropdown(
              title: '필러',
              value: filler,
              items: ['None', 'Baby\'s Breath', 'Eucalyptus'],
              onChanged: (value) {
                setState(() {
                  filler = value!;
                });
              },
            ),

            _buildDropdown(
              title: '포장지 색상',
              value: wrappingColor,
              items: ['White', 'Pink', 'White & Pink', 'Beige'],
              onChanged: (value) {
                setState(() {
                  wrappingColor = value!;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('프롬프트 생성하기'),
                onPressed: () {
                  final option = BouquetOption(
                    flowerType: flowerType,
                    flowerColor: flowerColor,
                    quantity: quantity,
                    filler: filler,
                    wrappingColor: wrappingColor,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultScreen(option: option),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
