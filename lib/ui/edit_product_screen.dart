import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory/constants/constants.dart';
import 'package:inventory/models/product_model.dart';

class EditProductScreen extends StatefulWidget {
  final int? id;
  const EditProductScreen({Key? key, this.id}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  Future putProduct(
      String namaBarang, String stok, String harga) async {
    var dio = Dio();

    dynamic data = {
      "id" : widget.id,
      "nama_barang": namaBarang,
      "stok" : stok,
      "harga" :harga
    };

    try {
      final response = await dio.put("${MyColors.baseUrl}/api/products/${widget.id}",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));

      print("Respon -> ${response.data} + ${response.statusCode}");

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print("Failed To Load $e");
    }
  }

  Future<List<ProductModel>> fetchProductData() async {
    final dio = Dio();
    String url = "${MyColors.baseUrl}/api/products/${widget.id}";

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    namaBarang = TextEditingController();
    stok = TextEditingController();
    harga = TextEditingController();
    _getProductData();
  }

  Future<void> _getProductData() async {
    try {
      List<ProductModel> productList = await fetchProductData();
      if (productList.isNotEmpty) {
        setState(() {
          namaBarang.text = productList[0].namaBarang ?? '';
          stok.text = (productList[0].stok as int).toString() ?? '';
          harga.text = (productList[0].harga).toString() ?? '';
        });
      }
    } catch (e) {
      print('Error fetching product: $e');
    }
  }

  TextEditingController namaBarang = TextEditingController();
  TextEditingController stok = TextEditingController();
  TextEditingController harga = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const _Header(),
              const Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    "Nama Barang",
                    style: TextStyle(
                      fontFamily: "AB",
                      fontSize: 20,
                      color: MyColors.whiteColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Container(
                height: 51,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xff777777),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextField(
                  controller: namaBarang,
                  style: const TextStyle(
                    fontFamily: "AM",
                    fontSize: 14,
                    color: MyColors.whiteColor,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),const Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    "Stok",
                    style: TextStyle(
                      fontFamily: "AB",
                      fontSize: 20,
                      color: MyColors.whiteColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Container(
                height: 51,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xff777777),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextField(
                  controller: stok,
                  style: const TextStyle(
                    fontFamily: "AM",
                    fontSize: 14,
                    color: MyColors.whiteColor,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),const Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    "Harga",
                    style: TextStyle(
                      fontFamily: "AB",
                      fontSize: 20,
                      color: MyColors.whiteColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Container(
                height: 51,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xff777777),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextField(
                  controller: harga,
                  style: const TextStyle(
                    fontFamily: "AM",
                    fontSize: 14,
                    color: MyColors.whiteColor,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  if (namaBarang.text.length != 0 && stok.text.length != 0 && harga.text.length != 0) {
                    await putProduct(
                        namaBarang.text,
                        stok.text,
                        harga.text)
                        .then((value) => {
                      if (value != null)
                        {
                          setState(() {
                            Navigator.pop(context);
                            Flushbar(
                              message: "Product berhasil diupdate",
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
                          })
                        }
                    });
                  } else {
                    Flushbar(
                      message: "Product harus diisi",
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
                },
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                    color: MyColors.greenColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontFamily: "AB",
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35, top: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.blackColor,
              ),
              child: Center(
                child: Image.asset(
                  "images/icon_arrow_left.png",
                  height: 16,
                  width: 16,
                ),
              ),
            ),
          ),
          const Text(
            "Edit Barang",
            style: TextStyle(
              fontFamily: "AB",
              fontSize: 20,
              color: MyColors.whiteColor,
            ),
          ),
          const SizedBox(
            height: 32,
            width: 32,
          ),
        ],
      ),
    );
  }
}
