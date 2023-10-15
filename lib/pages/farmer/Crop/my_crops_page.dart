import 'package:agrimart/provider/crops_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCropsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Crops'),
      ),
      body: Consumer<CropsProvider>(
        builder: (context, cropsProvider, child) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: cropsProvider.getAllCropsForFarmer(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              final cropsData = snapshot.data;

              if (cropsData == null || cropsData.isEmpty) {
                return Center(
                  child: Text('No crops found.'),
                );
              }

              return ListView.builder(
                itemCount: cropsData.length,
                itemBuilder: (context, index) {
                  final cropData = cropsData[index];
                  final cropName = cropData['cropName'] ?? 'Unknown Crop';
                  final cropVariety = cropData['cropCategory'] ?? 'Unknown Category';
                  final cropId = cropData['cropRegisterID']; // Replace 'cropId' with your actual field name
                  print('Crop ID: $cropId');
                  return ListTile(
                    title: Text(cropName),
                    subtitle: Text(cropVariety),
                    trailing: FutureBuilder<bool>(
                      future: cropsProvider.isBidStarted(cropId),
                      builder: (context, bidStartedSnapshot) {
                        if (bidStartedSnapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        final bool isBidStarted = bidStartedSnapshot.data ?? false;

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 40, // Specify the width as needed
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Implement the edit action here
                                  // You can navigate to an edit page for the selected crop
                                  // and pass the cropId to update the crop details.
                                  // Example: Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCropPage(cropId)));
                                },
                              ),
                            ),
                            if (!isBidStarted)
                              SizedBox(
                                width: 40, // Specify the width as needed
                                child: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Implement the delete action here
                                    // You can show a confirmation dialog to confirm deletion.
                                    // Example:
                                    showDialog(
                                     context: context,
                                       builder: (BuildContext context) {
                                        return AlertDialog(
                                           title: Text('Confirm Deletion'),
                                           content: Text('Are you sure you want to delete this crop?'),
                                           actions: [
                                             TextButton(
                                              onPressed: () {
                                               Navigator.of(context).pop(); // Close the dialog
                                              },
                                               child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // Print the cropId before performing the delete operation
  print('Deleting crop with ID: $cropId');
  
  // Perform the delete operation here
  cropsProvider.deleteCrop(cropId);
  
  // Print a message after attempting to delete (optional)
  print('Delete operation completed or attempted');
  
  Navigator.of(context).pop(); // Close the dialog
                                               },
                                               child: Text('Delete'),
                                             ),
                                           ],
                                         );
                                       },
                                     );
                                  },
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
