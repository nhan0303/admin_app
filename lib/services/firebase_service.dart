import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class FirebaseService {
  final CollectionReference _db = FirebaseFirestore.instance.collection(
    'products',
  );

  // Thêm sản phẩm
  Future<void> addProduct(Product p) async =>
      await _db.doc(p.idsanpham).set(p.toMap());

  // Sửa sản phẩm
  Future<void> updateProduct(Product p) async =>
      await _db.doc(p.idsanpham).update(p.toMap());

  // Xóa sản phẩm
  Future<void> deleteProduct(String id) async => await _db.doc(id).delete();

  // Lấy danh sách sản phẩm thời gian thực
  Stream<List<Product>> getProducts() {
    return _db.snapshots().map(
      (snap) =>
          snap.docs
              .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
              .toList(),
    );
  }
}
