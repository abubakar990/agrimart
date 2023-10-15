import 'package:agrimart/const/colors.dart';

import 'package:agrimart/models/users.dart';
import 'package:agrimart/pages/register/kyc_page/kyc_page_cnic.dart';
import 'package:agrimart/provider/auth_provider.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Create controllers for all fields
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, List<String>> pakistanCities = {
    'Punjab': ['Lahore', 'Faisalabad', 'Rawalpindi', 'Multan', 'Gujranwala'],
    'Sindh': ['Karachi', 'Hyderabad', 'Sukkur', 'Larkana', 'Nawabshah'],
    'Khyber Pakhtunkhwa': ['Peshawar', 'Abbottabad', 'Mardan', 'Swat', 'Kohat'],
    'Balochistan': ['Quetta', 'Gwadar', 'Sibi', 'Zhob', 'Khuzdar'],
    'Gilgit-Baltistan': ['Gilgit', 'Skardu', 'Chilas', 'Khaplu', 'Ghizer'],
    'Azad Jammu and Kashmir': ['Muzaffarabad', 'Mirpur', 'Rawalakot', 'Kotli', 'Bhimber'],
    'Islamabad Capital Territory': ['Islamabad'],
  };
  // Initialize variables to store selected province and city
  String? selectedProvince;
  String? selectedCity;
  bool isTermsChecked = false;
  String userType="Farmer";
  AuthProvider authProvider = AuthProvider();
  //UserRegistrationModel userRegistration = UserRegistrationModel();

  @override
  void initState() {
    super.initState();
    // Set the initial value for user type here
   // userRegistration.userType = 'Farmer';
  }

  @override
  Widget build(BuildContext context) {
    List<String> cities = selectedProvince != null ? pakistanCities[selectedProvince] ?? [] : [];
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: ListView(
            children: [
              // User Type Section
              SectionTitle(title: 'User Type'),
              ListTile(
                title: const Text('Farmer'),
                leading: Radio<String>(
                  value: 'Farmer',
                  groupValue: userType,
                  onChanged: (value) {
                    setState(() {
                     userType = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Buyer'),
                leading: Radio<String>(
                  value: 'Buyer',
                  groupValue: userType,
                  onChanged: (value) {
                    setState(() {
                      userType = value!;
                    });
                  },
                ),
              ),
              Divider(),

              // Personal Information Section
              SectionTitle(title: 'Personal Information'),
              _buildTextField(
                labelText: 'First Name',
                controller: firstNameController,
                onChanged: (value) {
                  firstNameController.text = value;
                },
                validator: (value) {
                  return _validateNotEmpty(value, 'Please enter your first name');
                },
              ),
              _buildTextField(
                labelText: 'Last Name',
                controller: lastNameController,
                onChanged: (value) {
                  lastNameController.text= value;
                },
                validator: (value) {
                  return _validateNotEmpty(value, 'Please enter your last name');
                },
              ),
              _buildTextField(
                labelText: 'Email Address',
                controller: emailController,
                onChanged: (value) {
                  emailController.text = value;
                },
                validator: (value) {
                  return _validateEmail(value);
                },
              ),
              _buildTextField(
                labelText: 'Password',
                controller: passwordController,
                onChanged: (value) {
                  passwordController.text = value;
                },
                validator: (value) {
                  return _validatePassword(value);
                },
                isPassword: true,
              ),
              _buildTextField(
                labelText: 'Confirm Password',
                controller: confirmPasswordController,
                onChanged: (value) {
                  //userRegistration.confirmPassword = value;
                },
                validator: (value) {
                  return _validatePasswordMatch(value, passwordController.text);
                },
                isPassword: true,
              ),
              _buildTextField(
                labelText: 'CNIC (e.g., 30301-2392631-2)',
                controller: cnicController,
                onChanged: (value) {
                cnicController.text = value;
                },
                validator: (value) {
                  return _validateCNIC(value);
                },
              ),
              _buildTextField(
                labelText: 'Mobile Number',
                controller: mobileNoController,
                onChanged: (value) {
                  mobileNoController.text = value;
                },
                validator: (value) {
                  return _validateMobileNumber(value);
                },
              ),

              // Add more personal information fields here
              Divider(),

              // Location Information Section
              SectionTitle(title: 'Location Information'),
              _buildTextField(
                labelText: 'Address',
                controller: addressController,
                onChanged: (value) {
                 addressController.text = value;
                },
                validator: (value) {
                  return _validateNotEmpty(value, 'Please enter your Address');
                },
              ),
              _buildDropdown(
                labelText: 'Select Province',
                value: selectedProvince,
                onChanged: (value) {
                  setState(() {
                    selectedProvince = value;
                    selectedCity = null; // Reset selected city when province changes
                  });
                },
                items: pakistanCities.keys.toList(),
              ),
              _buildDropdown(
                labelText: 'Select City',
                value: selectedCity,
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
                items: cities,
                enabled: selectedProvince != null,
              ),

              // Terms and Conditions
              SectionTitle(title: 'Terms and Conditions'),
              CheckboxListTile(
                title: Text('I agree to the terms and conditions'),
                value: isTermsChecked ?? false,
                onChanged: (value) {
                  setState(() {
                    isTermsChecked = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                subtitle: !(isTermsChecked ?? false)
                    ? Text(
                        'Please agree to the terms and conditions',
                        style: TextStyle(color: Colors.red),
                      )
                    : null,
              ),

              Divider(),

             ElevatedButton(
      onPressed: () async {
        // Validate and submit the form
        if (_formKey.currentState!.validate()) {
          try {
            // Set the date fields
            

            // Register the user with Firebase
            await authProvider.registerUser(
  email: emailController.text,
  password: passwordController.text, // Add the password from your password controller
  firstName: firstNameController.text,
  lastName: lastNameController.text,
  cnic: cnicController.text,
  mobile: mobileNoController.text,
  address: addressController.text,
  province: selectedProvince ?? "", // Make sure to handle null case if needed
  city: selectedCity ?? "", // Make sure to handle null case if needed
  userType: userType ?? "", // Make sure to handle null case if needed
  createdDate:DateTime.now(),
  
);


            // User registration was successful, navigate to KYC page
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => KYCPage()), // Replace with your KYC page
            );
          } catch (e) {
            // Handle any registration errors
            print('Registration Error: $e');
          }
        }
      },
      child: Text('Save And Continue'),
    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required void Function(String) onChanged,
    TextEditingController? controller,
    required String? Function(String?)? validator,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: appMainColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        validator: validator,
      ),
    );
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
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  String? _validateNotEmpty(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    // You can add more password criteria here (e.g., uppercase, lowercase, special characters)
    return null;
  }

  String? _validatePasswordMatch(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateCNIC(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your CNIC';
    }
    final cnicPattern = r'^\d{5}-\d{7}-\d{1}$';
    final regExp = RegExp(cnicPattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid CNIC (e.g., 30301-2392631-2)';
    }
    return null;
  }

  String? _validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    final mobilePattern = r'^\d{11}$';
    final regExp = RegExp(mobilePattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
