import 'package:agrimart/pages/farmer/farmers_dashboard.dart';
import 'package:agrimart/pages/mainApp/login_page.dart';
import 'package:agrimart/provider/auth_provider.dart';
import 'package:agrimart/widgets/loading_widget.dart';
import 'package:agrimart/widgets/mainApp_widgets/bottom_navigation_bar.dart';
import 'package:agrimart/widgets/mainApp_widgets/farmer_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Check if the user is authenticated
        if (authProvider.isAuthenticated) {
          // User is authenticated

          // Check if userData is available, and wait for it if necessary
          if (authProvider.userData != null) {
            // Now, you can access the user's role from the userData obtained from Firestore
            final userRole = authProvider.userData?['userType'];

            // Check the user's role and navigate accordingly
            if (userRole == 'Farmer') {
              // User is a farmer, navigate to the farmer's screen
              return const FarmerBottomNavigationBar(); // Replace with your farmer's screen/widget
            } else if (userRole == 'Buyer') {
              // User is a buyer, navigate to the buyer's screen
              return const MainAppBottomNavigationBar(); // Replace with your buyer's screen/widget
            }
          }

          // If userRole is still not determined, you can handle it here or return a loading indicator.
          return LoadingWidget(); // Replace with your loading indicator
        } else {
          // User is not authenticated, show the login page
          return LoginPage();
        }
      },
    );
  }
}
