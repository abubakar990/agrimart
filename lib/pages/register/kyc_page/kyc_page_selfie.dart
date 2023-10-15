import 'dart:io';

import 'package:agrimart/auth/login_check.dart';
import 'package:agrimart/const/colors.dart';
import 'package:agrimart/pages/mainApp/login_page.dart';
import 'package:agrimart/provider/auth_provider.dart';
import 'package:agrimart/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class KFCPageSelfie extends StatefulWidget {
  final String? frontImagePath;
  final String? backImagePath;
  const KFCPageSelfie({super.key, this.frontImagePath, this.backImagePath});

  @override
  State<KFCPageSelfie> createState() => _KFCPageSelfieState();
}

class _KFCPageSelfieState extends State<KFCPageSelfie> {
   final ImagePicker _picker = ImagePicker();
   AuthProvider authProvider = AuthProvider();
   XFile? _selfieImage;

  
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        // Handle the selected image here (e.g., save it or display it)
        // You can also upload the image to a server if needed
        _selfieImage =pickedFile;
        print('Image path: ${pickedFile.path}');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
  Widget _buildImageWithCross(XFile? imageFile, Function() onRemove) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image.file(
                File(imageFile!.path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
     var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('KYC Verification'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/cnic_dummy/selfie_dummy.jpg",),
            
           // Guidelines for taking a selfie
           
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Guidelines for taking a selfie:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
           
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  '1. Ensure good lighting for a clear picture.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  '2. Hold the camera at eye level for the best angle.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  '3. Remove any obstructions from your face.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            if (_selfieImage != null)
              _buildImageWithCross(_selfieImage, () {
                setState(() {
                  _selfieImage = null;
                });
              }),
          Container(
  width:width * 0.7 , // 70% of screen width
  height: height * 0.1 , // 20% of screen height
  decoration: BoxDecoration(
    border: Border.all(color: appMainColor), // Border color
    borderRadius: BorderRadius.circular(12), // Optional: Add border radius
  ),
  child: TextButton(
    onPressed: () {
      _pickImage(ImageSource.camera);
    },
    style: TextButton.styleFrom(
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Optional: Adjust padding
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

       
        Text(
          "Take Selfie",
          style: textTheme.headlineMedium!.copyWith(
            color: appMainColor,
            fontWeight: FontWeight.w400,
          ),
          
        ),
        SizedBox(width: 15),
         Icon(
          Icons.camera_alt_outlined,
          color: appMainColor,
        ),
        
      ],
    ),
  ),
),
SizedBox(height: 10,),
            Container(
  width:width * 0.8 , // 70% of screen width
  height: height * 0.1 , // 20% of screen height
  decoration: BoxDecoration(
    border: Border.all(color: Colors.white), // Border color
    borderRadius: BorderRadius.circular(12.0), // Optional: Add border radius
  ),
  child: TextButton(
    onPressed: () {
      authProvider.updateUserKYC(userCnicBackPic: widget.backImagePath!, userCnicFrontPic: widget.frontImagePath!, userProfilePic: _selfieImage!.path);
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginCheck()));
    },
    style: TextButton.styleFrom(
      backgroundColor: appMainColor,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Optional: Adjust padding
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
        Text(
          "Veirfy",
          style: textTheme.headlineMedium!.copyWith(
             color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          
        ),
        SizedBox(width: 15),
         Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        
      ],
    ),
  ),
)])));
  }
}