import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hs_flower/models/flower_item.dart';

class FlowerService {
  static final FlowerService _instance = FlowerService._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  factory FlowerService() {
    return _instance;
  }

  FlowerService._internal();

  Future<List<FlowerItem>> getItemsByCategory(String category) async {
    try {
      final snapshot = await _firestore
          .collection('items')
          .where('category', isEqualTo: category)
          .get();

      return snapshot.docs
          .map((doc) => FlowerItem.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error fetching items: $e');
      return [];
    }
  }

  Future<String> getImageUrl(String storagePath) async {
    try {
      final url = await _storage.ref(storagePath).getDownloadURL();
      return url;
    } catch (e) {
      print('Error getting image URL: $e');
      return '';
    }
  }

  Future<void> addItem(FlowerItem item) async {
    try {
      await _firestore.collection('items').add(item.toFirestore());
    } catch (e) {
      print('Error adding item: $e');
    }
  }
}
