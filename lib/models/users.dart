/*class UserRegistrationModel {
  String? userType; // User Type
  String? userId; // User ID
  String? cnic;
  String? firstName; // First Name
  String? lastName; // Last Name
  String? address;
  String? userCnicBackPic= ""; // User CNIC Back Picture URL
  String? userCnicFrontPic=""; // User CNIC Front Picture URL
  String? userProfilePic=""; // User Profile Picture URL
  String? briefProfile=""; // Brief Profile Description
  String? mobileNo; // Mobile Number
  String? email; // Email
  String? userRemarks; // User Remarks
  bool? active = false; // User Active Status
  String? submitStatus; // Submission Status
  DateTime? createdDate = DateTime.now(); // Created Date
  DateTime? submitDate; // Submission Date
  DateTime? updateDate; // Update Date
  String? verificationStatus; // Verification Status
  String? inputBy = "self"; // Input By
  DateTime? inputDate = DateTime.now(); // Input Date
  String? inputRemarks=""; // Input Remarks
  String? verificationBy; // Verified By
  DateTime? verificationDate; // Verification Date
  String? verificationRemarks; // Verification Remarks
  String? userStatus; // User Status
  String? userPassword; // User Password
  int? maxTry; // Max Try
  DateTime? passwordResetDate; // Password Reset Date
 
 

  UserRegistrationModel({
    this.userType,
    this.userId,
   
    this.cnic,
    this.firstName,
    this.lastName,
    this.userCnicBackPic,
    this.userCnicFrontPic,
    this.userProfilePic,
    this.briefProfile,
    
    this.mobileNo,
    this.email,
    this.userRemarks,
    this.active,
    this.submitStatus,
    this.createdDate,
    this.submitDate,
    this.updateDate,
    this.verificationStatus,
    this.inputBy,
    this.inputDate,
    this.inputRemarks,
    this.verificationBy,
    this.verificationDate,
    this.verificationRemarks,
    this.userStatus,
    this.userPassword,
    this.maxTry,
    this.passwordResetDate,
    
  });

  // Convert UserRegistrationModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'userType': userType,
      'userId': userId,
      'cnic': cnic,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'userCnicBackPic': userCnicBackPic,
      'userCnicFrontPic': userCnicFrontPic,
      'userProfilePic': userProfilePic,
      'briefProfile': briefProfile,
      'mobileNo': mobileNo,
      'email': email,
      'userRemarks': userRemarks,
      'active': active,
      'submitStatus': submitStatus,
      'createdDate': createdDate,
      'submitDate': submitDate,
      'updateDate': updateDate,
      'verificationStatus': verificationStatus,
      'inputBy': inputBy,
      'inputDate': inputDate,
      'inputRemarks': inputRemarks,
      'verificationBy': verificationBy,
      'verificationDate': verificationDate,
      'verificationRemarks': verificationRemarks,
      'userStatus': userStatus,
      'userPassword': userPassword,
      'maxTry': maxTry,
      'passwordResetDate': passwordResetDate,
    
    };
  }
}
*/