import 'package:flutter/material.dart';

class FarmerCropCard extends StatelessWidget {
  final String cropName;
  final String cropVariety;
  final String cropUnit;
  final int cropQuantity;
  final String cropDescription;
  final DateTime? bidStartDate;
  final DateTime? bidEndDate;
  final VoidCallback onDelete;

  FarmerCropCard({
    required this.cropName,
    required this.cropVariety,
    required this.cropUnit,
    required this.cropQuantity,
    required this.cropDescription,
    this.bidStartDate,
    this.bidEndDate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cropName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Variety: $cropVariety',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            'Unit: $cropUnit',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            'Quantity: $cropQuantity',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Text(
            'Description: $cropDescription',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          if (bidStartDate != null)
            Text(
              'Bid Start Date: ${bidStartDate.toString()}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          if (bidEndDate != null)
            Text(
              'Bid End Date: ${bidEndDate.toString()}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement your edit action here
                },
                child: Text('Edit'),
              ),
              ElevatedButton(
                onPressed: onDelete,
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
