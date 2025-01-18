import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inventory/constants/constants.dart';
import 'package:inventory/models/user_model.dart';
import 'package:inventory/ui/edit_profile_screen.dart';
import 'package:inventory/ui/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String? id;
  final String? nama;
  const ProfileScreen({Key? key, this.id, this.nama}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<UserModel>> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = fetchUserData();
  }

  Future<List<UserModel>> fetchUserData() async {
    final dio = Dio();
    String url = "${MyColors.baseUrl}/api/users/${widget.id}";

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load motivasi');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff101010),
                      width: 0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset("images/icon_arrow_left.png"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SplashScreen(),
                                  ),
                                );
                              },
                              child: Image.asset(
                                "images/icon_logout.png",
                                color: MyColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 55,
                                backgroundImage: AssetImage("images/artists/default-profile.png"),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Container(
                                height: 31,
                                width: 105,
                                decoration: BoxDecoration(
                                  color: MyColors.greenColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfileScreen(id: widget.id, nama: widget.nama),
                                      ),
                                    );
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        fontFamily: "AB",
                                        color: MyColors.whiteColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 65,
                              ),
                              FutureBuilder<List<UserModel>>(
                                future: fetchUserData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return const Text('No data available');
                                  } else {
                                    final userData = snapshot.data![0];
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              '${userData.nama ?? 'Nama Lengkap'}',  // Data nama dari API
                                              style: TextStyle(
                                                fontFamily: "AM",
                                                fontSize: 18,
                                                color: MyColors.whiteColor,
                                              ),
                                            ),
                                            Text(
                                              "Nama Lengkap",
                                              style: TextStyle(
                                                fontFamily: "AM",
                                                fontSize: 15,
                                                color: MyColors.lightGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '${userData.profesi ?? 'Profesi'}',  // Data profesi dari API
                                              style: TextStyle(
                                                fontFamily: "AM",
                                                fontSize: 18,
                                                color: MyColors.whiteColor,
                                              ),
                                            ),
                                            Text(
                                              "Profesi",
                                              style: TextStyle(
                                                fontFamily: "AM",
                                                fontSize: 15,
                                                color: MyColors.lightGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

