import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/constants/colors.dart';
import 'package:flutter_the_movie_db/screens/home_screen/home_screen.dart';
import 'package:flutter_the_movie_db/screens/profile_screen/profile_screen.dart';
import 'package:flutter_the_movie_db/widgets/custom_app_bar/custom_app_bar.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[HomeScreen(), ProfileScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'TMDB'),
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: colors['primary'],
        selectedItemColor: colors['white'],
        unselectedItemColor: colors['white_unselected'],
        selectedIconTheme: const IconThemeData(size: 29),
        unselectedIconTheme: const IconThemeData(size: 28),
        selectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        onTap: _onItemTapped,
      ),
    );
  }
}
