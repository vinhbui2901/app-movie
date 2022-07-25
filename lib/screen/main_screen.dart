import 'package:flutter/material.dart';
import 'package:movie_app/screen/home_screen/home_screen.dart';
import 'package:movie_app/screen/search_screen.dart';
import 'package:movie_app/screen/tv_show_screen.dart';
import 'package:movie_app/screen/user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _isSlectedIndex = 0;
  final screen = [
    HomeScreen(),
    TvShowScreen(),
    SearchScreen(),
    UserScreen(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _isSlectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_isSlectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.withOpacity(0.8),
        currentIndex: _isSlectedIndex,
        onTap: _onItemTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline_rounded), label: 'TV Show'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
      ),
    );
  }
}
