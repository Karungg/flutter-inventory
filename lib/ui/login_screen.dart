import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inventory/constants/constants.dart';
import 'package:inventory/ui/dashboard_screen.dart';

import '../models/login_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  String? id;
  String? nama;

  Future<LoginModels?> postLogin(String email, String password) async {
    var dio = Dio();

    Map<String, dynamic> data = {"email": email, "password": password};

    try {
      final response = await dio.post("${MyColors.baseUrl}/api/login",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));

      print("Respon -> ${response.data} + ${response.statusCode}");

      if (response.statusCode == 200) {
        final loginModel = LoginModels.fromJson(response.data);

        return loginModel;
      }
    } catch (e) {
      print("Failed To Load $e");
    }
    return null;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                    "Email",
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
                  controller: emailController,
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
                height: 8,
              ),
              const Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    "Password",
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
                  obscureText: true,
                  controller: passwordController,
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
                height: 35,
              ),
              GestureDetector(
                onTap: () async {
                  await postLogin(
                      emailController.text,
                      passwordController.text)
                      .then((value) => {
                    if (value != null)
                      {
                        setState(() {
                          id = value.data?.id;
                          nama = value.data?.nama;
                          Navigator.pushReplacement(
                              context, MaterialPageRoute( builder: (BuildContext context) => DashBoardScreen(id: id!, nama: nama!)));
                        })
                      }
                    else if (value == null)
                      {
                        Flushbar(
                          message: "Email atau password salah.",
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
                        ).show(context)
                      }
                  });
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
                      "Login",
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
            "Login",
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
