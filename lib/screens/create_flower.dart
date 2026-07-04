import 'package:flutter/material.dart';
import 'package:hs_flower/models/flower_item.dart';
import 'package:hs_flower/services/flower_service.dart';

class CreateFlower extends StatefulWidget {
  const CreateFlower({super.key});

  static const blue = Color(0xFF4674C3);
  static const gray = Color(0xFFAFAFAF);

  @override
  State<CreateFlower> createState() => _CreateFlowerState();
}

class _CreateFlowerState extends State<CreateFlower> {
  String selectedCategory = '꽃';
  String? selectedItemId;
  FlowerItem? selectedItem;
  Map<String, int> colorQuantities = {};

  final FlowerService _flowerService = FlowerService();
  final List<String> categories = ['꽃', '필러', '포장지', '리본', '문구'];
  Map<String, List<FlowerItem>> itemsByCategory = {};

  @override
  void initState() {
    super.initState();
    _loadAllCategories();
  }

  Future<void> _loadAllCategories() async {
    for (String category in categories) {
      final items = await _flowerService.getItemsByCategory(category);
      setState(() {
        itemsByCategory[category] = items;
      });
    }
  }

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
                Container(
                  height: 56,
                  color: Colors.white,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            '나만의 꽃 만들기',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

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
                          children: categories.map((category) {
                            return CategoryButton(
                              text: category,
                              isSelected: selectedCategory == category,
                              onTap: () {
                                setState(() {
                                  selectedCategory = category;
                                  selectedItemId = null;
                                  selectedItem = null;
                                  colorQuantities.clear();
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: itemsByCategory[selectedCategory]?.isNotEmpty ?? false
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: itemsByCategory[selectedCategory]!
                                      .map((item) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedItemId = item.id;
                                          selectedItem = item;
                                          colorQuantities.clear();
                                        });
                                      },
                                      child: FlowerBox(
                                        item: item,
                                        isSelected: selectedItemId == item.id,
                                        flowerService: _flowerService,
                                      ),
                                    );
                                  }).toList(),
                                )
                              : Center(
                                  child: Text(
                                    '항목 로드 중...',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
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
                  color: CreateFlower.blue,
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
                  child: selectedItem == null || selectedItem!.colors.isEmpty
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
                            ...selectedItem!.colors.asMap().entries.map((entry) {
                              final colorName = entry.value;
                              final isLast =
                                  entry.key == selectedItem!.colors.length - 1;
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
                        color: CreateFlower.blue,
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
        color: isSelected ? CreateFlower.blue : CreateFlower.gray,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class FlowerBox extends StatefulWidget {
  final FlowerItem item;
  final bool isSelected;
  final FlowerService flowerService;

  const FlowerBox({
    super.key,
    required this.item,
    this.isSelected = false,
    required this.flowerService,
  });

  @override
  State<FlowerBox> createState() => _FlowerBoxState();
}

class _FlowerBoxState extends State<FlowerBox> {
  String? _imageUrl;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final url = await widget.flowerService.getImageUrl(widget.item.storagePath);
    setState(() {
      _imageUrl = url;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 128,
      decoration: BoxDecoration(
        color: widget.isSelected ? CreateFlower.blue : Colors.grey[300],
        border: widget.isSelected
            ? Border.all(color: CreateFlower.blue, width: 3)
            : null,
      ),
      child: _loading
          ? const Center(child: CircularProgressIndicator())
          : _imageUrl != null
              ? Image.network(
                  _imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text(
                        widget.item.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: widget.isSelected ? Colors.white : Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    widget.item.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.isSelected ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
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
          color: CreateFlower.blue,
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
        color: CreateFlower.blue,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
