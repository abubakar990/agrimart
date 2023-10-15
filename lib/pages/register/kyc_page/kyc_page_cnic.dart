import 'dart:io';
import 'package:agrimart/const/colors.dart';
import 'package:agrimart/pages/register/kyc_page/kyc_page_selfie.dart';
import 'package:agrimart/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class KYCPage extends StatefulWidget {
  @override
  _KYCPageState createState() => _KYCPageState();
}

class _KYCPageState extends State<KYCPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _cnicFrontImage;
  XFile? _cnicBackImage;

  Future<void> _pickFrontImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _cnicFrontImage = pickedFile;
        });
      }
    } catch (e) {
      print('Error picking front image: $e');
    }
  }

  Future<void> _pickBackImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _cnicBackImage = pickedFile;
        });
      }
    } catch (e) {
      print('Error picking back image: $e');
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
            SizedBox(
              child: Image.asset("assets/cnic_dummy/cnic_dummy.jpg"),
            ),
            // Display the selected CNIC Front Image
            if (_cnicFrontImage != null)
              _buildImageWithCross(_cnicFrontImage, () {
                setState(() {
                  _cnicFrontImage = null;
                });
              }),
            Container(
              width: width * 0.7,
              height: height * 0.1,
              decoration: BoxDecoration(
                border: Border.all(color:appMainColor), // Border color
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {
                  _pickFrontImage();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Capture CNIC Front",
                      style: TextStyle(
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
            SizedBox(height: 10),
            // Display the selected CNIC Back Image
            if (_cnicBackImage != null)
              _buildImageWithCross(_cnicBackImage, () {
                setState(() {
                  _cnicBackImage = null;
                });
              }),
            Container(
              width: width * 0.7,
              height: height * 0.1,
              decoration: BoxDecoration(
                border: Border.all(color:appMainColor), // Border color
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextButton(
                onPressed: () {
                  _pickBackImage();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Capture CNIC Back",
                      style: TextStyle(
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
            SizedBox(height: 30),
            Container(
              width: width * 0.8,
              height: height * 0.1,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white), // Border color
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => KFCPageSelfie(
          frontImagePath: _cnicFrontImage?.path,
          backImagePath: _cnicBackImage?.path,
        ),
      ),
    );
                },
                style: TextButton.styleFrom(
                  backgroundColor: appMainColor,
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Continue",
                      style: textTheme.headline2!.copyWith(color: Colors.white)
                    ),
                    SizedBox(width: 15),
                    Icon(
                      
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
