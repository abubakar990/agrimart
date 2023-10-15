import 'package:agrimart/const/colors.dart';
import 'package:agrimart/pages/farmer/farmers_dashboard.dart';
import 'package:agrimart/pages/mainApp/search_crops_page.dart';
import 'package:agrimart/pages/mainApp/categories_page.dart';
import 'package:agrimart/pages/mainApp/chat/chat_list_page.dart';
import 'package:agrimart/pages/mainApp/homepage.dart';
import 'package:agrimart/pages/mainApp/main_app_profile_page.dart';
import 'package:agrimart/pages/mainApp/messages_page.dart';
import 'package:agrimart/pages/mainApp/my_auctions_page.dart';
import 'package:agrimart/provider/auth_provider.dart';
import 'package:agrimart/widgets/farmer_dashboard_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FarmerBottomNavigationBar extends StatefulWidget {
  const FarmerBottomNavigationBar({super.key});

  @override
  _FarmerBottomNavigationBarState createState() =>
      _FarmerBottomNavigationBarState();
}

class _FarmerBottomNavigationBarState
    extends State<FarmerBottomNavigationBar> {
       
  int _currentIndex = 0; // Initial selected index
  

  final List<Widget> _pages = [
    FarmersDashboard(),
    CropSearchPage(),
    ChatListPage(),
    MyAuctionsPage(userType: UserType.farmer,),
   // CategoriesPage(),
    MainAppProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
     final authProvider = Provider.of<AuthProvider>(context);
    final userData = authProvider.userData;
    final farmerName = userData!['firstName'];
   final profilePictureUrl = userData!['userProfilePic'];
   print(profilePictureUrl);
    final farmerEmail = userData['email'] ?? "";
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.notifications),
          
        ],
        elevation: 0,
        backgroundColor: appMainColor,
      ),
      drawer: FarmerDashboardDrawer(farmerName: farmerName,farmerEmail: farmerEmail,profilePictureUrl: profilePictureUrl,),
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
