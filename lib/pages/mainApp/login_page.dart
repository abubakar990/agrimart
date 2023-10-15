import 'package:agrimart/const/colors.dart';
import 'package:agrimart/pages/mainApp/forget_password%20_page.dart';
import 'package:agrimart/pages/mainApp/register_page.dart';
import 'package:agrimart/theme/text_theme.dart';
import 'package:agrimart/widgets/mainApp_widgets/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Regular expression for email format validation
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  @override
  void dispose() {
    // Dispose of the controllers to free up resources
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction, // Auto-validation on user interaction
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.6,
                        child: Image.asset("assets/agrimart_logo/agrimart_logo.png"),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(child: Text("Welcome to Agrimart", style: textTheme.headline4)),
                    Center(child: Text("Please sign in to continue", style: textTheme.labelLarge)),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return 'Invalid email format';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordPage()));
                        },
                        child: Text("Forget Password",style: textTheme.headline6!.copyWith(fontStyle: FontStyle.italic))),
                    ), 
                    SizedBox(height: 25,),
                    SizedBox(
                      height: height * 0.07,
                      width: width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: appMainColor),
                        onPressed: () async {
  // Validate the form
  if (_formKey.currentState!.validate()) {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      // Use FirebaseAuth to sign in the user with email and password
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Authentication successful, userCredential contains user information
      final user = userCredential.user;

      // Navigate to the main app screen upon successful login
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainAppBottomNavigationBar()));
    } catch (e) {
      // Handle authentication failure, e.g., show an error message
      print('Login failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ),
      );
    }
  }
},child: Text('Sign In', style: textTheme.headline3!.copyWith(color: Colors.white),),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Don't have an account? "), GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationPage()));
                        },
                        child: Text("Register",style: textTheme.headline6!.copyWith(fontSize: 14,color: appMainColor),))],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
