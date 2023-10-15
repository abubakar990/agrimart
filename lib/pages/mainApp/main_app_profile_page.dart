import 'package:agrimart/auth/login_check.dart';
import 'package:agrimart/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:firebase_auth/firebase_auth.dart';
 

class MainAppProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use a Consumer widget to access user data from the Auth Provider
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Get user data from the Auth Provider
        final user = authProvider.user;
        final userData = authProvider.userData; // Define userData in AuthProvider

        // Check if the user is authenticated
        if (user != null && userData != null) {
          // Access user details from userData
          final firstName = userData['firstName'];
          final lastName = userData['lastName'];
          final cnic = userData['cnic'];
          final phone = userData['mobile'];
          final location = userData['address'];
          final userType = userData['userType'];

          return Scaffold(
            appBar: AppBar(
              title: Text("Profile Page"),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          // backgroundImage: NetworkImage(user.photoURL ?? ''),
                        ),
                        SizedBox(height: 20),
                        Text(
                          firstName ?? 'N/A',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.email ?? 'N/A',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('CNIC: ${cnic ?? 'N/A'}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone: ${phone ?? 'N/A'}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Location: ${location ?? 'N/A'}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text('Role: ${userType ?? 'N/A'}'),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => signOutAndNavigateToLogin(context, authProvider), // Pass authProvider
              child: Icon(Icons.logout),
            ),
          );
        } else {
          // Handle the case when the user is not authenticated
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile Page'),
            ),
            body: Center(
              child: Text('User is not authenticated. Please log in.'),
            ),
          );
        }
      },
    );
  }

  // Update the sign-out function to use the Auth Provider
  Future<void> signOutAndNavigateToLogin(BuildContext context, AuthProvider authProvider) async {
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
}
