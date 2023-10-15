import 'package:flutter/material.dart';

class FilterDialogWidget extends StatefulWidget {
  final Function(String selectedLocation) onApply; // Add the onApply callback

  FilterDialogWidget({required this.onApply});

  @override
  _FilterDialogWidgetState createState() => _FilterDialogWidgetState();
}

class _FilterDialogWidgetState extends State<FilterDialogWidget> {
  String cropName = '';
  int minPrice = 0;
  int maxPrice = 1000000;
  String selectedLocation = ''; // Update to store the selected location filter
  int minQuantity = 0;
  int maxQuantity = 1000;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter Crops'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Crop Name'),
            onChanged: (value) {
              setState(() {
                cropName = value;
              });
            },
          ),
          _buildSliderWithTitle('Min Price:', minPrice.toDouble(), (value) {
            setState(() {
              minPrice = value.toInt();
            });
          }, min: 0, max: maxPrice.toDouble()),
          _buildSliderWithTitle('Max Price:', maxPrice.toDouble(), (value) {
            setState(() {
              maxPrice = value.toInt();
            });
          }, min: minPrice.toDouble(), max: 1000000),
          _buildLocationDropdown(), // Add the location filter dropdown
          _buildSliderWithTitle('Min Quantity:', minQuantity.toDouble(), (value) {
            setState(() {
              minQuantity = value.toInt();
            });
          }, min: 0, max: maxQuantity.toDouble()),
          _buildSliderWithTitle('Max Quantity:', maxQuantity.toDouble(), (value) {
            setState(() {
              maxQuantity = value.toInt();
            });
          }, min: minQuantity.toDouble(), max: 1000),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Pass the selected location back to the parent widget
            widget.onApply(selectedLocation);
            Navigator.of(context).pop();
          },
          child: Text('Apply'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              cropName = '';
              minPrice = 0;
              maxPrice = 1000000;
              selectedLocation = ''; // Clear the selected location filter
              minQuantity = 0;
              maxQuantity = 1000;
            });
            Navigator.of(context).pop();
          },
          child: Text('Clear'),
        ),
      ],
    );
  }

  Widget _buildSliderWithTitle(
      String title, double value, ValueChanged<double> onChanged,
      {required double min, required double max}) {
    return Column(
      children: [
        Text('$title $value'),
        Slider(
          value: value,
          onChanged: onChanged,
          min: min,
          max: max,
        ),
      ],
    );
  }

  Widget _buildLocationDropdown() {
    return DropdownButton<String>(
      value: selectedLocation,
      onChanged: (String? newValue) {
        setState(() {
          selectedLocation = newValue ?? '';
        });
      },
      items: <String>['', 'Lahore', 'Islamabad', 'Karachi'] // Add your location options here
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: Text('Select Location'), // Displayed when no location is selected
    );
  }
}
