import 'package:agrimart/models/crop_info.dart';
import 'package:agrimart/pages/register/kyc_page/kyc_page_cnic.dart';
import 'package:agrimart/provider/auth_provider.dart';
import 'package:agrimart/widgets/mainApp_widgets/crop_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? _firstName;
  String? _lastName;

  @override
  void initState() {
    super.initState();
    // Fetch additional user details from AuthProvider
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      // Use Provider to access user data from AuthProvider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      Map<String, dynamic>? userData = authProvider.userData;

      if (userData != null) {
        // Access user details from the userData map
        _firstName = userData['firstName'];
        _lastName = userData['lastName'];

        // Update the UI with the retrieved user details
        setState(() {});
      }
    } catch (e) {
      // Handle any errors that may occur during retrieval
      print('Error fetching user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListTile(
            title: Text("KYC Verification"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => KYCPage()));
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: height * 0.15,
                  child: Image.asset("assets/agrimart_logo/agrimart_logo.png"),
                ),
              ),
              if (_firstName == null)
                const Text(
                  "Hi, Dear",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                Text(
                  "Hi, $_firstName $_lastName",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(height: height * 0.02),
              Text("Just For You", style: TextStyle(fontSize: 20)),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('crops').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text('No crops found.'),
                      );
                    }

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: width / (height * 0.7),
                      ),
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final cropDoc = snapshot.data!.docs[index];
                        final cropData = cropDoc.data() as Map<String, dynamic>;

                        // Check if cropData is null or doesn't contain expected data
                        if (cropData == null || !cropData.containsKey('cropRegisterID')) {
                          print('Invalid crop data at index $index: $cropData');
                          // Handle the invalid data as needed
                          return SizedBox(); // Placeholder or error message
                        }

                        // Create a Crop object from cropData
                        final crop = Crop.fromMap(cropData);

                        return AspectRatio(
                          aspectRatio: 0.8,
                          child: CropCard(crop: crop),
                        );
                      },
                    );
                  },
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
