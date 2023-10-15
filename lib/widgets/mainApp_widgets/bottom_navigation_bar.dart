import 'package:agrimart/const/colors.dart';
import 'package:agrimart/pages/mainApp/search_crops_page.dart';
import 'package:agrimart/pages/mainApp/categories_page.dart';
import 'package:agrimart/pages/mainApp/chat/chat_list_page.dart';
import 'package:agrimart/pages/mainApp/homepage.dart';
import 'package:agrimart/pages/mainApp/main_app_profile_page.dart';
import 'package:agrimart/pages/mainApp/messages_page.dart';
import 'package:agrimart/pages/mainApp/my_auctions_page.dart';
import 'package:flutter/material.dart';

class MainAppBottomNavigationBar extends StatefulWidget {
  const MainAppBottomNavigationBar({super.key});

  @override
  _MainAppBottomNavigationBarState createState() =>
      _MainAppBottomNavigationBarState();
}

class _MainAppBottomNavigationBarState
    extends State<MainAppBottomNavigationBar> {
  int _currentIndex = 0; // Initial selected index

  final List<Widget> _pages = [
    Homepage(),
    CropSearchPage(),
    ChatListPage(),
    MyAuctionsPage(userType: UserType.farmer,),
   // CategoriesPage(),
    MainAppProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: appMainColor,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.black,fontSize: 15),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse Crops',
            //activeIcon: Icon(Icons.search_outlined,)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_outlined),
            label: 'Messages',
            activeIcon: Icon(Icons.comment)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'My Auctions',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Define your HomePage, CategoriesPage, and ProfilePage classes here.
