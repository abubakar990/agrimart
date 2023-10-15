import 'package:flutter/material.dart';

class BuyerRegistrationScreen extends StatefulWidget {
  @override
  _BuyerRegistrationScreenState createState() =>
      _BuyerRegistrationScreenState();
}

class _BuyerRegistrationScreenState extends State<BuyerRegistrationScreen> {
  final TextEditingController _industryController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyLocationController =
      TextEditingController();
  final TextEditingController _kycDocumentsController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _industryController.dispose();
    _companyNameController.dispose();
    _companyLocationController.dispose();
    _kycDocumentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer Registration'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _industryController,
                decoration: InputDecoration(labelText: 'Industry Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your industry type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _companyNameController,
                decoration: InputDecoration(labelText: 'Company Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your company name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _companyLocationController,
                decoration: InputDecoration(labelText: 'Company Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your company location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kycDocumentsController,
                decoration: InputDecoration(
                    labelText: 'KYC Documents (e.g., Business Registration)'),
                validator: (value) {
                  // Add KYC documents validation logic here
                  return null; // Return an error message if the KYC documents are invalid
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form validation successful, implement your registration logic here
                    // You can access the entered values using the controllers
                  }
                },
                child: Text('Register as Buyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
