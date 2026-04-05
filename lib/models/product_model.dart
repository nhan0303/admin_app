class Product {
  String idsanpham, tensp, loaisp, hinhanh;
  double gia;

  Product({
    required this.idsanpham,
    required this.tensp,
    required this.loaisp,
    required this.gia,
    required this.hinhanh,
  });

  Map<String, dynamic> toMap() => {
    'idsanpham': idsanpham,
    'tensp': tensp,
    'loaisp': loaisp,
    'gia': gia,
    'hinhanh': hinhanh,
  };

  factory Product.fromMap(Map<String, dynamic> map) => Product(
    idsanpham: map['idsanpham'] ?? '',
    tensp: map['tensp'] ?? '',
    loaisp: map['loaisp'] ?? '',
    gia: (map['gia'] ?? 0).toDouble(),
    hinhanh: map['hinhanh'] ?? '',
  );
}
