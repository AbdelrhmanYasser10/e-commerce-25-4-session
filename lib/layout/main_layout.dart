import 'package:e_commerce_app_session/screens/cateogry_screen.dart';
import 'package:e_commerce_app_session/screens/favourite_screen.dart';
import 'package:e_commerce_app_session/screens/home_screen.dart';
import 'package:e_commerce_app_session/screens/profile_screen.dart';
import 'package:e_commerce_app_session/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';


class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  List<Widget> screens = const[
    HomeScreen(),
    CategoryScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];
  int currentIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIdx,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: AppColors.primaryColor,
        onTap: (value) {
          setState(() {
            currentIdx = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
            label: "Category"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
              ),
            label: "Favourite"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
            label: "Profile"
          ),
        ],
      ),
      body: screens[currentIdx],
    );
  }
}
