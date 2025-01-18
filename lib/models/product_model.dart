class ProductModel {
  final int? id;
  final String? namaBarang;
  final int? stok;
  final double? harga;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    this.id,
    this.namaBarang,
    this.stok,
    this.harga,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int?,
      namaBarang: json['nama_barang'],
      stok: json['stok'] as int?,
      harga: json['harga'] is String
          ? double.tryParse(json['harga'])
          : (json['harga'] as num?)?.toDouble(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_barang': namaBarang,
      'stok': stok,
      'harga': harga,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
