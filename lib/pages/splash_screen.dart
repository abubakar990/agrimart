import 'package:flutter/material.dart';
import 'package:agrimart/auth/login_check.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late Animation<double> positionAnimation;
  late Animation<double> sizeAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 2 seconds
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));

    // Create two separate animations, one for position and one for size
    positionAnimation = Tween<double>(begin: 1.0, end: 0.4).animate(animationController);
    sizeAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(animationController);

    // Start the animation
    animationController.forward();

    // Use a Future.delayed to navigate after the animation completes
    Future.delayed(Duration(seconds: 3), () {
      navigateToNextScreen();
    });
  }

  void navigateToNextScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginCheck()));
  }

  @override
  void dispose() {
    // Dispose of the animation controller when done
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return Align(
              alignment: Alignment(0, -1 + (positionAnimation.value) * 2),
              child: FractionalTranslation(
                translation: Offset(0, (1 - (positionAnimation.value)) / 2),
                child: Image.asset(
                  "assets/agrimart_logo/agrimart_logo.png",
                  width: sizeAnimation.value,
                  height: sizeAnimation.value,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
