import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;

  User? get user => _user;
  Map<String, dynamic>? _userData;

  Map<String, dynamic>? get userData => _userData;

  AuthProvider() {
    _initAuth();
  }

 void _initAuth() {
  _auth.authStateChanges().listen((User? user) async {
    _user = user;
    notifyListeners();

    if (user != null) {
      try {
        // Fetch and store user data when the user is authenticated
        _userData = await getUserDataFromFirestore(user.uid);
        notifyListeners();
      } catch (e) {
        // Handle any errors that occur during data retrieval
        print('Error fetching user data: $e');
      }
    }
  });
}


Future<Map<String, dynamic>> getUserDataFromFirestore(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        return userSnapshot.data() ?? {};
      } else {
        throw Exception('User document does not exist');
      }
    } catch (e) {
      throw e;
    }
  }
  
  Future<Map<String, dynamic>> fetchUserData() async {
    if (_user != null) {
      // Fetch and store user data when the user is authenticated
      _userData = await getUserDataFromFirestore(_user!.uid);
      notifyListeners();
      return _userData!;
    } else {
      return {};
    }
  }
  Future<void> updateUserKYC({
  required String userCnicBackPic,
  required String userCnicFrontPic,
  required String userProfilePic,
}) async {
  try {
    if (_user != null) {
      // Generate unique file names for uploaded images
      final String uid = _auth.currentUser!.uid;
      final String cnicFrontFileName = '$uid-front.jpg';
      final String cnicBackFileName = '$uid-back.jpg';
      final String profilePicFileName = '$uid-dp.jpg';

      // Upload images to Firebase Storage
      final Reference storageRef = FirebaseStorage.instance.ref();

      final cnicFrontRef = storageRef.child('cnic_images/$cnicFrontFileName');
      final cnicBackRef = storageRef.child('cnic_images/$cnicBackFileName');
      final profilePicRef = storageRef.child('selfie_images/$profilePicFileName');

      // Upload images to Firebase Storage
      final UploadTask cnicFrontTask =
          cnicFrontRef.putFile(File(userCnicFrontPic));

      final UploadTask cnicBackTask =
          cnicBackRef.putFile(File(userCnicBackPic));

      final UploadTask profilePicTask =
          profilePicRef.putFile(File(userProfilePic));

      // Wait for all uploads to complete
      await Future.wait([
        cnicFrontTask.whenComplete(() => null),
        cnicBackTask.whenComplete(() => null),
        profilePicTask.whenComplete(() => null),
      ]);

      // Get the download URLs of the uploaded images
      final String cnicFrontUrl = await cnicFrontRef.getDownloadURL();
      final String cnicBackUrl = await cnicBackRef.getDownloadURL();
      final String profilePicUrl = await profilePicRef.getDownloadURL();

      // Update user KYC data with the download URLs
      final userKYCData = {
        'userCnicFrontPic': cnicFrontUrl,
        'userCnicBackPic': cnicBackUrl,
        'userProfilePic': profilePicUrl,
      };

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update(userKYCData);

      // Registration and data storage successful
    } else {
      throw Exception('User creation failed');
    }
  } catch (e) {
    throw e;
  }
}

  
 
Future<void> registerUser({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required String cnic,
  required String mobile,
  required String address,
  required String province,
  required String city,
  required String userType,
  required DateTime createdDate,
  String userCnicBackPic ="",
  String userCnicFrontPic= "",
  String userProfilePic = "",
  String profileDescription = "",
  bool verificationStatus = false,
  String verifiedBy ='',
  DateTime? verificationSate,
  String? verificationRemarks,
  String userStatus = "Active",
  int maxTry = 5,
  DateTime? passwordResetDate

      
  
}) async {
  try {
    // Create a user with email and password
    await _auth.createUserWithEmailAndPassword(email: email, password: password);

    // Get the current user
    final User? user = _auth.currentUser;

    if (user != null) {
      // User registration successful, now store user data in Firestore
      final userData = {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'cnic': cnic,
        'mobile': mobile,
        'address': address,
        'province': province,
        'city': city,
        'userType': userType,
        'createdDate': createdDate,
        'userCnicBackPic': userCnicBackPic,
      'userCnicFrontPic': userCnicFrontPic,
      'userProfilePic': userProfilePic,
      'profileDescription': profileDescription,
      'verificationStatus':verificationStatus,
      'verifiedBy' : verifiedBy,
  'verificationSate':verificationSate,
  'verificationRemarks':verificationRemarks,
  'userStatus' : userStatus,
  'maxTry' : maxTry,
  'passwordResetDate':passwordResetDate
        
      };

      // Store user data in Firestore under 'users' collection with user's UID as the document ID
      await _firestore.collection('users').doc(user.uid).set(userData);

      // Registration and data storage successful
    } else {
      throw Exception('User creation failed');
    }
  } catch (e) {
    throw e;
  }
}

 /* Future<void> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String cnic,
    required String mobile,
    required String address,
    required String province,
    required String city,
    required String userType,
    
  }) async {
    try {
      // Create a user with email and password
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Registration successful
    } catch (e) {
      throw e;
    }
  }*/

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with email and password
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Sign-in successful
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }

  bool get isAuthenticated => _user != null;
}
