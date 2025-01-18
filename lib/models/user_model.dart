class UserModel {
  final String? id;
  final String? nama;
  final String? profesi;
  final String? email;
  final String? password;

  UserModel({
    this.id,
    this.nama,
    this.profesi,
    this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      nama: json['nama'].toString(),
      profesi: json['profesi'].toString(),
      email: json['email'].toString(),
      password: json['password'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'profesi': profesi,
      'email': email,
      'password': password,
    };
  }
}
