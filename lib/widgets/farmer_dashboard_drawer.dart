import 'package:agrimart/auth/login_check.dart';
import 'package:agrimart/const/colors.dart';
import 'package:agrimart/pages/farmer/Crop/my_crops_page.dart';
import 'package:agrimart/pages/mainApp/homepage.dart';
import 'package:agrimart/pages/mainApp/search_crops_page.dart';
import 'package:agrimart/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FarmerDashboardDrawer extends StatelessWidget {
  final String farmerName;
  final String? profilePictureUrl;
  final String farmerEmail;
  

  FarmerDashboardDrawer({
    Key? key,
    required this.farmerName,
    required this.profilePictureUrl,
    required this.farmerEmail,
 
  });

  Future<void> signOutAndNavigateToLogin(
      BuildContext context, AuthProvider authProvider) async {
    try {
      await authProvider.signOut(); // Use the Auth Provider's signOut method
      print('User signed out successfully');

      // Navigate to the login page
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginCheck(),
      ));
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          
        return ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: appMainColor),
              accountName: Text(farmerName),
              accountEmail: Text(farmerEmail),
              currentAccountPicture: CircleAvatar(
               // backgroundImage: NetworkImage(profilePictureUrl!),
                radius: 30,
              ),
            ),
            ListTile(
              leading: Icon(Icons.auto_graph_rounded),
              title: Text('Prediction and Analytics'),
              onTap: () {
                // Navigate to prediction and analytics screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text('My Crops'),
              onTap: () {
                // Navigate to My Crops screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCropsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Home Page'),
              onTap: () {
                // Navigate to Home Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search Crops'),
              onTap: () {
                // Navigate to Crop Search Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CropSearchPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Transaction History'),
              onTap: () {
                // Navigate to transaction history screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings screen or perform settings actions
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile Management'),
              onTap: () {
                // Navigate to profile management screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Farm Management'),
              onTap: () {
                // Navigate to farm management screen
                Navigator.pop(context);
              },
            ),
            Divider(), // A divider to separate items
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                // Perform logout action
                 signOutAndNavigateToLogin(context, authProvider);
              },
            ),
          ],
        );
        },),);
    
  }
}
