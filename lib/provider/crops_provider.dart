import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CropsProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int sameFarmerCrops = 0;

  User? _user;

  CropsProvider() {
    _user = _auth.currentUser;
  }

  Future<int> getCropCountForFarmer(String farmerId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> cropSnapshot = await _firestore
          .collection('crops')
          .where('farmerId', isEqualTo: farmerId)
          .get();

      final int cropCount = cropSnapshot.docs.length;
      sameFarmerCrops = cropCount;
      return cropCount;
    } catch (e) {
      // Handle any errors that may occur during the data retrieval process
      print('Error retrieving crop count: $e');
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getAllCropsForFarmer() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> cropSnapshot = await _firestore
          .collection('crops')
          .where('farmerId', isEqualTo: _user?.uid)
          .get();

      if (cropSnapshot.docs.isNotEmpty) {
        return cropSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      } else {
        // Handle the case where no crops are found for the farmer
        return [];
      }
    } catch (e) {
      // Handle any errors that may occur during the data retrieval process
      print('Error retrieving crops: $e');
      return [];
    }
  }
Future<void> deleteCrop(String cropRegisterId) async {
  try {
    // Query for the crop document with the matching cropRegisterId field
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('crops')
        .where('cropRegisterID', isEqualTo: cropRegisterId)
        .get();

    // Check if any documents match the query
    if (querySnapshot.docs.isNotEmpty) {
      // Loop through the matching documents (although there should be only one)
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
        // Get the document reference and data
        final DocumentReference<Map<String, dynamic>> cropRef = doc.reference;
        final Map<String, dynamic> cropData = doc.data() ?? {};

        // Create a new document in "deleted_crops" collection
        final DocumentReference<Map<String, dynamic>> deletedCropRef =
            await _firestore.collection('deleted_crops').add(cropData);

        // Delete the original crop document from "crops" collection
        await cropRef.delete();

        print('Crop deleted successfully: ${deletedCropRef.id}');
      }
    } else {
      print('No matching crop document found.');
    }

    // Notify listeners to update the UI after deletion
    notifyListeners();
  } catch (e) {
    // Handle any errors that may occur during the deletion process
    print('Error deleting crop: $e');
  }
}


  Future<List<Map<String, dynamic>>> searchCrops({
    String? cropName,
    String? location,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection('crops');

      if (cropName != null && cropName.isNotEmpty) {
        query = query.where('cropName', isEqualTo: cropName);
      }

      if (location != null && location.isNotEmpty) {
        query = query.where('location', isEqualTo: location);
      }

      final QuerySnapshot<Map<String, dynamic>> cropSnapshot = await query.get();

      if (cropSnapshot.docs.isNotEmpty) {
        return cropSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      } else {
        // Handle the case where no crops match the search criteria
        return [];
      }
    } catch (e) {
      // Handle any errors that may occur during the data retrieval process
      print('Error searching crops: $e');
      return [];
    }
  }
Future<bool> isBidStarted(String cropId) async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> cropDoc =
        await _firestore.collection('crops').doc(cropId).get();

    final Map<String, dynamic> cropData = cropDoc.data() ?? {};

    // Check if bidStartTime exists and is not null
    if (cropData['bidStartTime'] != null) {
      final DateTime bidStartTime = cropData['bidStartTime'].toDate();
      DateTime currentTime = DateTime.now();
      return currentTime.isAfter(bidStartTime);
    }

    // If bidStartTime doesn't exist or is null, return false
    return false;
  } catch (e) {
    // Handle any errors that may occur during the data retrieval process
    print('Error checking bid status: $e');
    return false;
  }
}


  Future<bool> isBidEnded(String cropId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> cropDoc = await _firestore
          .collection('crops')
          .doc(cropId)
          .get();

      final Map<String, dynamic> cropData = cropDoc.data() ?? {};
      final DateTime bidEndTime = cropData['bidEndTime'].toDate();

      DateTime currentTime = DateTime.now();
      return currentTime.isAfter(bidEndTime);
    } catch (e) {
      // Handle any errors that may occur during the data retrieval process
      print('Error checking bid status: $e');
      return false;
    }
  }
}
