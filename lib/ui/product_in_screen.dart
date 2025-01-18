import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/ui/edit_product_in_screen.dart';
import 'package:inventory/ui/edit_product_screen.dart';
import 'package:inventory/ui/profile_screen.dart';
import 'package:inventory/ui/setting_screen.dart';
import '../constants/constants.dart';
import '../models/product_model.dart';
import 'add_product_in_screen.dart';
import 'add_product_screen.dart';

class ProductInScreen extends StatefulWidget {
  final String? id;
  final String? nama;

  const ProductInScreen({Key? key, this.id, this.nama}) : super(key: key);

  @override
  State<ProductInScreen> createState() => _ProductInScreenState();
}

class _ProductInScreenState extends State<ProductInScreen> {
  late Future<List<ProductModel>> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = fetchProductData();
  }

  Future<List<ProductModel>> fetchProductData() async {
    final dio = Dio();
    const String url = "${MyColors.baseUrl}/api/products-in";

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future deleteProduct(
      String productId) async {
    var dio = Dio();

    dynamic data = {
      "id" : productId,
    };

    try {
      final response = await dio.delete("${MyColors.baseUrl}/api/products-in/$productId",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));

      print("Respon -> ${response.data} + ${response.statusCode}");

      if (response.statusCode == 200) {
        Flushbar(
          message: "Barang masuk berhasil dihapus",
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.black, // Dark background
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          icon: Icon(
            Icons.check_circle, // Icon yang menunjukkan keberhasilan
            size: 28,
            color: Colors.greenAccent,
          ),
          messageColor: Colors.white, // Warna teks pesan
          title: "Berhasil", // Menambahkan judul (opsional)
          titleColor: Colors.greenAccent, // Warna judul
          boxShadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, 3),
              blurRadius: 5,
            ),
          ],
        ).show(context);
      }
    } catch (e) {
      print("Failed To Load $e");
      Flushbar(
        message: "Barang masuk gagal dihapus",
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.black, // Dark background
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        icon: Icon(
          Icons.warning, // Icon yang menunjukkan keberhasilan
          size: 28,
          color: Colors.redAccent,
        ),
        messageColor: Colors.white, // Warna teks pesan
        title: "Gagal", // Menambahkan judul (opsional)
        titleColor: Colors.redAccent, // Warna judul
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(0, 3),
            blurRadius: 5,
          ),
        ],
      ).show(context);
    }
  }

  void _refreshMotivasi() {
    setState(() {
      _productFuture = fetchProductData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blackColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25, top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingScreen(),
                                ),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                  AssetImage("images/artists/default-profile.png"),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Halo ${widget.nama}',
                                  style: TextStyle(
                                    fontFamily: "AB",
                                    fontSize: 24,
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddProductInScreen(id: widget.id, nama: widget.nama),
                                      ),
                                    );
                                  },
                                  child: Image.asset("images/icon_add.png"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileScreen(id: widget.id, nama: widget.nama),
                                      ),
                                    );
                                  },
                                  child: Image.asset("images/icon_settings.png"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "images/arrow_component_down.png",
                                    width: 10,
                                    height: 12,
                                  ),
                                  Image.asset(
                                    "images/arrow_component_up.png",
                                    width: 10,
                                    height: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Baru ditambahkan",
                                style: TextStyle(
                                  fontFamily: "AM",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: _refreshMotivasi,
                            child: Image.asset('images/icon-refresh.png'),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: FutureBuilder<List<ProductModel>>(
                      future: fetchProductData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No products in available.', style: TextStyle(color: MyColors.whiteColor)));
                        } else {
                          final motivasiList = snapshot.data!;
                          return Column(
                            children: List.generate(motivasiList.length, (index) {
                              final product = motivasiList[index];
                              return Card(
                                color: MyColors.blackColor,
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColors.whiteColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ListTile(
                                    title: Text('Nama Barang : ' + (product.namaBarang ?? 'nama barang'), style: TextStyle(color: MyColors.whiteColor)),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Stok : ' + (product.stok ?? 0).toString(), style: TextStyle(color: MyColors.whiteColor)),
                                        Text('Harga : Rp.'+(product.harga ?? 0).toString(), style: TextStyle(color: MyColors.whiteColor)),
                                        Text('Tanggal Masuk : '+(product.createdAt ?? '').toString(), style: TextStyle(color: MyColors.whiteColor))
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit, color: MyColors.whiteColor),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditProductInScreen(id: product.id),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete, color: MyColors.whiteColor),
                                          onPressed: () {
                                            deleteProduct(product.id.toString());
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        }
                      },
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 130),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
