import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/product_model.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseService _service = FirebaseService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin - Quản lý sản phẩm')),
      body: StreamBuilder<List<Product>>(
        stream: _service.getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return ListTile(
                leading:
                    p.hinhanh.isNotEmpty
                        ? Image.network(p.hinhanh, width: 50)
                        : const Icon(Icons.image),
                title: Text(p.tensp),
                subtitle: Text('${p.loaisp} - ${p.gia}đ'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditScreen(product: p),
                            ),
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _service.deleteProduct(p.idsanpham),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddEditScreen()),
            ),
      ),
    );
  }
}
