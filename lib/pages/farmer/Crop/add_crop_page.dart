import 'package:agrimart/const/colors.dart';
import 'package:agrimart/models/crop_info.dart';
import 'package:agrimart/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class AddCropPage extends StatefulWidget {
  @override
  _AddCropPageState createState() => _AddCropPageState();
}

class _AddCropPageState extends State<AddCropPage> {
  final TextEditingController cropNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController cropQualityController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController bidStartDateController = TextEditingController();
  final TextEditingController bidEndDateController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController inspectionRequestController =
      TextEditingController();
      Map<String, List<String>> cropCategories = {
  'Fruits': ['Apple', 'Banana', 'Orange'],
  'Vegetables': ['Carrot', 'Tomato', 'Broccoli'],
  'Grains': ['Rice', 'Wheat', 'Barley'],
  // Add more categories and their sub-categories as needed...
};
List<String> unitList=['Kg','mound','ton'];
   
  String? selectedUnit; // Default unit
  bool qualityInspectionRequest = false;
  String? selectedCategory ; // Set a default category
String? selectedSubCategory; // Set a default sub-category


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<XFile>? _selectedImages = [];

  DateTime? _selectedBidStartDate;
  DateTime? _selectedBidEndDate;

  Future<int> getCropCountForFarmer(String farmerId) async {
    try {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('farmers') // Replace with your Firestore collection name
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

  Future<void> _addCropToFirestore() async {
    try {
      // Ensure the user is authenticated
      final User? user = _auth.currentUser;
      if (user == null) {
        // User is not authenticated, handle as needed (e.g., show a login screen)
        return;
      }
      final String farmerId = user.uid;
      final int cropCount = await getCropCountForFarmer(farmerId);
      final String cropId = '$farmerId-$cropCount';

      // Upload selected images to Firebase Storage
      List<String> imageUrls = await uploadImages(cropNameController.text, cropId);

      // Create a Crop object with image URLs
      final Crop crop = Crop(
        cropRegisterID: cropId,
        farmerId: farmerId,
        cropName: cropNameController.text,
        cropCategory: selectedCategory.toString()??'',
        cropSubCategory: selectedSubCategory.toString()??'',
        cropQuality: cropQualityController.text,
        cropUnit: selectedUnit.toString()??'',
        cropImageURLs: imageUrls,
        cropQuantity: int.tryParse(quantityController.text) ?? 0,
        cropAskPrice: double.tryParse(priceController.text) ?? 0.0,
        cropDescription: descriptionController.text,
        cropRemarks: "OK",
        bidStartDate: _selectedBidStartDate ?? DateTime.now(),
        bidEndDate: _selectedBidEndDate ?? DateTime.now(),
        active: true,
        qualityInspectionRequest: qualityInspectionRequest,
        createdDate: DateTime.now(),
        submitDate: DateTime.now(),
        updateDate: DateTime.now(),
      );

      // Convert the Crop object to a Map
      final Map<String, dynamic> cropData = {
        'cropRegisterID': crop.cropRegisterID,
        'farmerId': crop.farmerId,
        'cropName': crop.cropName,
        'cropCategory':crop.cropCategory,
        'cropSubCategory': crop.cropSubCategory,
        'cropUnit': crop.cropUnit,
        'cropQuantity': crop.cropQuantity,
        'cropAskPrice': crop.cropAskPrice,
        'cropDescription': crop.cropDescription,
        'cropRemarks': crop.cropRemarks,
        'bidStartDate': crop.bidStartDate.toUtc(),
        'bidEndDate': crop.bidEndDate.toUtc(),
        'active': crop.active,
        'qualityInspectionRequest': crop.qualityInspectionRequest,
        'createdDate': crop.createdDate.toUtc(),
        'submitDate': crop.submitDate.toUtc(),
        'updateDate': crop.updateDate.toUtc(),
        'cropImageURLs': crop.cropImageURLs,
      };

      await _firestore.collection('crops').add(cropData);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingWidget()));

      Navigator.pop(context); // Navigate back to the previous screen
    } catch (e) {
      print('Error adding crop to Firestore: $e');
      // Handle the error as needed
    }
  }


void removeImage(int index) {
  setState(() {
    _selectedImages!.removeAt(index);
  });
}

Future<void> _selectImages() async {
  final List<XFile>? selectedImages = await _imagePicker.pickMultiImage();
  if (selectedImages != null && selectedImages.isNotEmpty) {
    setState(() {
      if (_selectedImages == null) {
        _selectedImages = [];
      }

      for (final XFile newImage in selectedImages) {
        // Add each selected image to the list
        _selectedImages!.add(newImage);
      }
    });
  }
}






  Future<List<String>> uploadImages(String cropName, String cropId) async {
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < _selectedImages!.length; i++) {
        final XFile imageFile = _selectedImages![i];
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
  

  Future<void> _selectBidStartDate(BuildContext context) async {
  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: _selectedBidStartDate ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.utc(2024),
  );

  if (selectedDate != null) {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedBidStartDate ?? DateTime.now()),
    );

    if (selectedTime != null) {
      setState(() {
        // Combine selectedDate and selectedTime into a single DateTime
        _selectedBidStartDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        bidStartDateController.text = _selectedBidStartDate!.toString();
      });
    }
  }
}

Future<void> _selectBidEndDate(BuildContext context) async {
  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: _selectedBidEndDate ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.utc(2024),
  );

  if (selectedDate != null) {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedBidEndDate ?? DateTime.now()),
    );

    if (selectedTime != null) {
      setState(() {
        // Combine selectedDate and selectedTime into a single DateTime
        _selectedBidEndDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        bidEndDateController.text = _selectedBidEndDate!.toString();
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
   final width= MediaQuery.of(context).size.width;
   final height= MediaQuery.of(context).size.height;
    final OutlineInputBorder focusedBorderDecoration = OutlineInputBorder(
         
          
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appMainColor),
         
        );
        final OutlineInputBorder enabledBorderDecoration = 
         
         OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          
         
        );
        final OutlineInputBorder errorBorderDecoration = OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red),
         
        );
    List<String> subCategory = selectedCategory != null ? cropCategories[selectedCategory] ?? [] : [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Crop'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdown(labelText: "Select Crop Category", value: selectedCategory,  onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                    selectedSubCategory = null;
                  });
                },
                items: cropCategories.keys.toList(),
                
                 ),
                 _buildDropdown(
                labelText: 'Select Sub Category',
                value: selectedSubCategory,
                onChanged: (value) {
                  setState(() {
                    selectedSubCategory = value;
                  });
                },
                items: subCategory,
                enabled: selectedCategory != null,
              ),
             
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: cropNameController,
                  decoration: InputDecoration(labelText: 'Crop Name',focusedBorder: focusedBorderDecoration,errorBorder: errorBorderDecoration,enabledBorder: enabledBorderDecoration),
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description',focusedBorder: focusedBorderDecoration,errorBorder: errorBorderDecoration,enabledBorder: enabledBorderDecoration),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Recommended Price',focusedBorder: focusedBorderDecoration,errorBorder: errorBorderDecoration,enabledBorder: enabledBorderDecoration),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: cropQualityController,
                  decoration: InputDecoration(labelText: 'Crop Quality',focusedBorder: focusedBorderDecoration,errorBorder: errorBorderDecoration,enabledBorder: enabledBorderDecoration),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildDropdown(labelText: "Select Crop Unit", value: selectedUnit,  onChanged: (value) {
                    setState(() {
                      selectedUnit = value!;
                      
                    });
                  },
                  items: unitList.toList(),
                  
                   ),
            ),

              
              GestureDetector(
                onTap: () => _selectBidStartDate(context),
                child: AbsorbPointer(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: bidStartDateController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_view_month_rounded,color: appMainColor,),labelText: 'Bid Start Date',focusedBorder: focusedBorderDecoration,errorBorder: errorBorderDecoration,enabledBorder: enabledBorderDecoration),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _selectBidEndDate(context),
                child: AbsorbPointer(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      
                      controller: bidEndDateController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_view_month_rounded,color: appMainColor,),
                        labelText: 'Bid End Date',focusedBorder: focusedBorderDecoration,errorBorder: errorBorderDecoration,enabledBorder: enabledBorderDecoration),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: quantityController,
                  decoration: InputDecoration(labelText: 'Quantity Available',focusedBorder: focusedBorderDecoration,errorBorder: errorBorderDecoration,enabledBorder: enabledBorderDecoration),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CheckboxListTile(
                  title: const Text('Quality Inspection Request'),
                  value: qualityInspectionRequest,
                  onChanged: (value) {
                    setState(() {
                      qualityInspectionRequest = value!;
                    });
                  },
                ),
              ),
             /* Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: inspectionRequestController,
                  decoration: InputDecoration(
                      labelText: 'Quality Inspection Request',focusedBorder: focusedBorderDecoration,errorBorder: errorBorderDecoration,enabledBorder: enabledBorderDecoration),
                ),
              ),
              // Add other fields as needed

              */
              const SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                children: [
                  for (int i = 0; i < _selectedImages!.length; i++)
                    Stack(
                      children: [
                        Image.file(File(_selectedImages![i].path), width: 100, height: 100),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                onTap: () => removeImage(i),
                child: const Icon(Icons.close, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              ),

              Center(
                child: SizedBox(
                  height: height*0.06,
                  width: width*0.6,
                  child: ElevatedButton(
                    onPressed: _selectImages,
                    
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Select Images',style: TextStyle(fontSize: 18),),
                        SizedBox(width:10),
                        Icon(Icons.camera_alt_outlined,size: 40,)
                      ],
                    ),
                  ),
                ),
              ),
             /* if (_selectedImages != null && _selectedImages!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selected Images:'),
                    for (int i = 0; i < _selectedImages!.length; i++)
                      Text(_selectedImages![i].name),
                  ],
                ),*/

                const SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.08,
               
                child: ElevatedButton(
                  onPressed: _addCropToFirestore,
                  style: ElevatedButton.styleFrom(backgroundColor: appMainColor,foregroundColor: Colors.white),
                  child: const Text('Add Crop',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          
            
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    cropNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    cropQualityController.dispose();
    unitController.dispose();
    bidStartDateController.dispose();
    bidEndDateController.dispose();
    quantityController.dispose();
    inspectionRequestController.dispose();
    super.dispose();
  }
}

Widget _buildDropdown({
    required String labelText,
    required String? value,
    required void Function(String?) onChanged,
    List<String> items = const [],
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          enabled: enabled,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appMainColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
