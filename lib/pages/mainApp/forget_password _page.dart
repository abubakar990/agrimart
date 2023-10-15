import 'package:agrimart/const/colors.dart';
import 'package:agrimart/theme/text_theme.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var _mobileNoController;
    var _emailController;
    var _CNICController;
      final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text("Forget Password"),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                            controller: _CNICController,
                            decoration: InputDecoration(
                              labelText: 'CNIC',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TextFormField(
    
                            controller: _mobileNoController,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){
                          //TOTO: Send Email to reset password
                        }, 
                        style:ElevatedButton.styleFrom(backgroundColor: appMainColor,),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12,left: 30,right: 30,bottom: 12),
                          child: Text("Forget Password",style: textTheme.headlineMedium!.copyWith(color: Colors.white),),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}