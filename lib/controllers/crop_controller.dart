/*
class CropController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<int> getCropCountForFarmer(String farmerId) async {
    try {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users') // Replace with your Firestore collection name
          .doc(farmerId) // Assuming each farmer has a unique document ID
          .get();

      if (documentSnapshot.exists) {
        final Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        final int cropCount = data['cropCount'] ?? 0; // Assuming you have a 'cropCount' field
        return cropCount;
      } else {
        // Handle the case where the document doesn't exist (e.g., farmer not found)
        return 0;
      }
    } catch (e) {
      // Handle any errors that may occur during the data retrieval process
      print('Error retrieving crop count: $e');
      return 0;
    }
  }
/*
  Future<List<String>> uploadImages(
      List<XFile> selectedImages, String cropName, String cropId) async {
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < selectedImages.length; i++) {
        final XFile imageFile = selectedImages[i];
        final File file = File(imageFile.path);
        final String fileName = '$cropName-$cropId-$i.jpg';

        final Reference storageReference =
            _storage.ref().child('crop_images/$fileName');
        print('Uploading image $i to: ${storageReference.fullPath}');

        final UploadTask uploadTask = storageReference.putFile(file);

        await uploadTask.whenComplete(() async {
          final imageUrl = await storageReference.getDownloadURL();
          imageUrls.add(imageUrl);
        });
      }
    } catch (e) {
      print('Error uploading images: $e');
    }

    return imageUrls;
  }

  Future<void> addCrop({
    required BuildContext context,
    required String cropName,
    required String description,
    required double price,
    required String cropQuality,
    required String unit,
    required DateTime bidStartDate,
    required DateTime bidEndDate,
    required int quantity,
    required bool inspectionRequest,
    required List<XFile> selectedImages,
    required Function(List<String>) onImagesUploaded,
  }) async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        // User is not authenticated, handle as needed (e.g., show a login screen)
        return;
      }
      final String farmerId = user.uid;
      final int cropCount = await getCropCountForFarmer(farmerId);
      final String cropId = '$farmerId-$cropCount';

      List<String> imageUrls = await uploadImages(
        selectedImages,
        cropName,
        cropId,
      );

      final Map<String, dynamic> cropData = {
        'cropRegisterID': cropId,
        'farmerId': farmerId,
        'cropName': cropName,
        'cropUnit': unit,
        'cropQuantity': quantity,
        'cropAskPrice': price,
        'cropDescription': description,
        'cropRemarks': "OK",
        'bidStartDate': bidStartDate.toUtc(),
        'bidEndDate': bidEndDate.toUtc(),
        'active': true,
        'qualityInspectionRequest': inspectionRequest,
        'createdDate': DateTime.now().toUtc(),
        'submitDate': DateTime.now().toUtc(),
        'updateDate': DateTime.now().toUtc(),
        'cropImageURLs': imageUrls,
      };

      await _firestore.collection('crops').add(cropData);

      onImagesUploaded(imageUrls);

      // Navigate back to the previous screen
      Navigator.pop(context);
    } catch (e) {
      print('Error adding crop to Firestore: $e');
      // Handle the error as needed
    }
    
  }*/
}*/
