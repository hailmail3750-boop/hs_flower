class FlowerItem {
  final String id;
  final String name;
  final String category;
  final String storagePath;
  final List<String> colors;

  FlowerItem({
    required this.id,
    required this.name,
    required this.category,
    required this.storagePath,
    required this.colors,
  });

  factory FlowerItem.fromFirestore(Map<String, dynamic> data, String docId) {
    return FlowerItem(
      id: docId,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      storagePath: data['storagePath'] ?? '',
      colors: List<String>.from(data['colors'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'category': category,
      'storagePath': storagePath,
      'colors': colors,
    };
  }
}
