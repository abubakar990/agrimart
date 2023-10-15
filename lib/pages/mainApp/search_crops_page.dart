import 'package:agrimart/models/crop_info.dart';
import 'package:agrimart/widgets/mainApp_widgets/crop_tile.dart';
import 'package:agrimart/widgets/mainApp_widgets/filter_dialog_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CropSearchPage extends StatefulWidget {
  @override
  _CropSearchPageState createState() => _CropSearchPageState();
}

class _CropSearchPageState extends State<CropSearchPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  String _selectedLocation = ''; // Add a variable to store the selected location filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Enter crop name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                    style: TextStyle(fontSize: 16.0),
                    onChanged: (value) {
                      setState(() {
                        _searchText = value.toLowerCase();
                      });
                      _updateSearchResults();
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showFilterDialog(); // Show the filter dialog when the filter icon is pressed
                  },
                  icon: Icon(Icons.filter_alt_outlined ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('crops').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final crops = snapshot.data!.docs;

                List<Widget> searchResults = [];

                for (var crop in crops) {
                  final cropData = crop.data() as Map<String, dynamic>;

                  // Extract relevant fields for searching
                  final cropName = cropData['cropName'].toString().toLowerCase();
                 // final location = cropData['location'].toString().toLowerCase();

                  // Check if the crop matches the search text and location filter
                  if (_matchesSearchCriteria(cropData)) {
                    searchResults.add(buildCropCard(cropData)); // Customize the UI for displaying crops
                  }
                }

                if (searchResults.isEmpty) {
                  return Center(
                    child: Text('No crops found.'),
                  );
                }

                return ListView(
                  children: searchResults,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCropCard(Map<String, dynamic> cropData) {
    // Customize the UI for displaying crops here
    return CropCard(crop: Crop.fromMap(cropData));
  }

  // Function to show the filter dialog
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialogWidget(
          onApply: (String selectedLocation) {
            setState(() {
              _selectedLocation = selectedLocation; // Update the selected location filter
            });
            _updateSearchResults();
          },
        );
      },
    );
  }

  void _updateSearchResults() {
    // You can perform additional filtering here if needed
    setState(() {
      // Perform your search and update the search results
    });
  }

  bool _matchesSearchCriteria(Map<String, dynamic> cropData) {
  final cropName = cropData['cropName'].toString().toLowerCase();
  // Comment out the location search for now
  // final location = cropData['location'].toString().toLowerCase();

  if (_searchText.isNotEmpty && !cropName.contains(_searchText)) {
    return false;
  }

  // Commented out location search
  /*if (_selectedLocation.isNotEmpty && location != _selectedLocation) {
    return false;
  }*/

  return true;
}

}
