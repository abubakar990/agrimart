import 'package:agrimart/auth/login_check.dart';
import 'package:agrimart/const/colors.dart';
import 'package:agrimart/firebase_options.dart';
import 'package:agrimart/pages/splash_screen.dart';
import 'package:agrimart/provider/auth_provider.dart';
import 'package:agrimart/provider/crops_provider.dart';
import 'package:agrimart/theme/text_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => CropsProvider()), // Replace with your user type provider
      ],
      child: MaterialApp(
        title: 'AgriMart',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: appMainColor),
          useMaterial3: true,
          textTheme: textTheme,
        ),
        home: SplashScreen(),
        // You can set the initial page based on the user's authentication status
        // For example:
        // home: Consumer<AuthProvider>(
        //   builder: (context, authProvider, _) {
        //     if (authProvider.isAuthenticated) {
        //       return FarmersDashboard(
        //         farmerName: 'Abu Bakar',
        //         profilePictureUrl:
        //             "https://drive.google.com/file/d/1QshGQf0lRmRFcDu4_LTI-42-BU5ODVDV/view?usp=drive_link",
        //         farmerEmail: 'ch.abubakar998@gmail.com',
        //       );
        //     } else {
        //       return LoginCheck(); // Or your login page
        //     }
        //   },
        // ),
      ),
    );
  }
}
