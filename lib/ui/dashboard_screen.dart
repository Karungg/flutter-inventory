import 'package:flutter/material.dart';
import 'package:inventory/constants/constants.dart';
import 'package:inventory/ui/home_screen.dart';
import 'package:inventory/ui/product_in_screen.dart';
import 'package:inventory/ui/product_out_screen.dart';
import 'package:inventory/ui/return_screen.dart';

class DashBoardScreen extends StatefulWidget {
  final String? id;
  final String? nama;
  const DashBoardScreen({Key? key, this.id, this.nama}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        height: 64,
        width: MediaQuery.of(context).size.width,
        color: MyColors.blackColor.withOpacity(0.95),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedLabelStyle: const TextStyle(fontFamily: "AM", fontSize: 13),
            selectedItemColor: const Color(0xffE5E5E5),
            unselectedItemColor: MyColors.lightGrey,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('images/icon_home.png'),
                activeIcon: Image.asset('images/icon_home_active.png'),
                label: "Beranda",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/icon_library.png',
                  color: MyColors.lightGrey,
                ),
                activeIcon: Image.asset(
                  'images/icon_library_active.png',
                  color: MyColors.whiteColor,
                ),
                label: "Barang Masuk",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/icon_library.png',
                  color: MyColors.lightGrey,
                ),
                activeIcon: Image.asset(
                  'images/icon_library_active.png',
                  color: MyColors.whiteColor,
                ),
                label: "Barang Keluar",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/icon_library.png',
                  color: MyColors.lightGrey,
                ),
                activeIcon: Image.asset(
                  'images/icon_library_active.png',
                  color: MyColors.whiteColor,
                ),
                label: "Retur",
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(id: widget.id, nama: widget.nama),
          ProductInScreen(id: widget.id, nama: widget.nama),
          ProductOutScreen(id: widget.id, nama: widget.nama),
          ReturnScreen(id: widget.id, nama: widget.nama)
        ],
      ),
    );
  }
}
