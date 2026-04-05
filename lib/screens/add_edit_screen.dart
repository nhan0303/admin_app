import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../services/firebase_service.dart';

class AddEditScreen extends StatefulWidget {
  final Product? product;
  const AddEditScreen({super.key, this.product});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _tenController = TextEditingController();
  final _loaiController = TextEditingController();
  final _giaController = TextEditingController();
  final _urlController = TextEditingController(); // Dùng nhập link ảnh
  final _service = FirebaseService();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _tenController.text = widget.product!.tensp;
      _loaiController.text = widget.product!.loaisp;
      _giaController.text = widget.product!.gia.toString();
      _urlController.text = widget.product!.hinhanh;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Thêm Sản Phẩm' : 'Sửa Sản Phẩm'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tenController,
              decoration: const InputDecoration(labelText: 'Tên sản phẩm'),
            ),
            TextField(
              controller: _loaiController,
              decoration: const InputDecoration(labelText: 'Loại sản phẩm'),
            ),
            TextField(
              controller: _giaController,
              decoration: const InputDecoration(labelText: 'Giá'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Link hình ảnh (URL)',
              ),
              onChanged:
                  (val) =>
                      setState(() {}), // Để cập nhật ảnh xem trước bên dưới
            ),
            const SizedBox(height: 20),
            // Hiển thị ảnh xem trước từ Link
            _urlController.text.isNotEmpty
                ? Image.network(
                  _urlController.text,
                  height: 150,
                  errorBuilder: (c, e, s) => const Text("Link ảnh lỗi!"),
                )
                : const Icon(Icons.image, size: 100, color: Colors.grey),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () async {
                final id =
                    widget.product?.idsanpham ??
                    FirebaseFirestore.instance.collection('products').doc().id;
                final p = Product(
                  idsanpham: id,
                  tensp: _tenController.text,
                  loaisp: _loaiController.text,
                  gia: double.tryParse(_giaController.text) ?? 0,
                  hinhanh: _urlController.text,
                );

                if (widget.product == null) {
                  await _service.addProduct(p);
                } else {
                  await _service.updateProduct(p);
                }
                if (!mounted) return;
                Navigator.pop(context);
              },
              child: const Text("LƯU DỮ LIỆU"),
            ),
          ],
        ),
      ),
    );
  }
}
