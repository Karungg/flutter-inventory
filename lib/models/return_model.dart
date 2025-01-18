class ReturnModel {
  final int? id;
  final String? namaBarang;
  final String? namaRetur;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ReturnModel({
    this.id,
    this.namaBarang,
    this.namaRetur,
    this.createdAt,
    this.updatedAt,
  });

  factory ReturnModel.fromJson(Map<String, dynamic> json) {
    return ReturnModel(
      id: json['id'] as int?,
      namaBarang: json['nama_barang'],
      namaRetur: json['nama_retur'],
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
      'nama_retur': namaRetur,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
