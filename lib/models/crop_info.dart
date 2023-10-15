/*class CropInfo {
  int cropID;
  String cropName;
  String cropDescription;
  List<String> cropImageURLs;
  DateTime bidStartTime;
  DateTime bidEndTime;
  String recommendedPrice; // Updated to string for price
  int farmID;
  String cropVariety;
  String cropQuality; // Added for crop variety
  int quantityAvailable; // Added for available quantity
  String sellerName; // Added for seller information
  String sellerLocation; // Added for seller location
  double sellerRating; // Added for seller rating
  double? winningBidPrice; // Added for winning bid price, nullable
  String? winningBidder; // Added for winning bidder name, nullable
  bool? isBidCompleted=false; // Added for bid completion status, nullable
  double? bidCurrentPrice=0; // Added for current bid price, nullable
  bool? isPaymentDone=false; // Added for payment status, nullable
  bool? isCropShipped=false; // Added for shipment status, nullable
  bool? isCropInspected=false; // Added for inspection status, nullable
  int? inspectorID; // Added for inspector ID, nullable

  CropInfo({
    required this.cropID,
    required this.cropName,
    required this.cropImageURLs,
    required this.bidStartTime,
    required this.bidEndTime,
    required this.recommendedPrice,
    required this.farmID,
    required this.cropVariety,
    required this.cropQuality,
    required this.quantityAvailable,
    required this.sellerName,
    required this.sellerLocation,
    required this.sellerRating,
    required this.cropDescription,
    this.winningBidPrice, // Initialize as null
    this.winningBidder, // Initialize as null
    this.isBidCompleted, // Initialize as null
    this.bidCurrentPrice, // Initialize as null
    this.isPaymentDone, // Initialize as null
    this.isCropShipped, // Initialize as null
    this.isCropInspected, // Initialize as null
    this.inspectorID, // Initialize as null
  });
}
*/
class Crop {
  String cropRegisterID;
  String farmerId;
  String cropName;
  String cropUnit;
  String cropCategory;
  String? cropSubCategory;
  List<String> cropImageURLs;
  int cropQuantity;
  String cropQuality;
  double cropAskPrice;
  String cropDescription;
  String? cropRemarks;
  DateTime bidStartDate;
  DateTime bidEndDate;
  bool active;
  bool qualityInspectionRequest;
  DateTime createdDate;
  DateTime submitDate;
  DateTime updateDate;

  Crop({
    required this.cropRegisterID,
    required this.farmerId,
    required this.cropName,
    required this.cropUnit,
    required this.cropCategory,
    this.cropSubCategory,
    required this.cropQuantity,
    required this.cropQuality,
    required this.cropImageURLs,
    required this.cropAskPrice,
    required this.cropDescription,
    this.cropRemarks = "OK",
    required this.bidStartDate,
    required this.bidEndDate,
    this.active = true,
    required this.qualityInspectionRequest,
    required this.createdDate,
    required this.submitDate,
    required this.updateDate,
  });

  factory Crop.fromMap(Map<String, dynamic> map) {
    return Crop(
      cropRegisterID: map['cropRegisterID'] ?? '',
      farmerId: map['farmerId'] ?? '',
      cropName: map['cropName'] ?? '',
      cropCategory: map['cropCategory']??'',
      cropSubCategory: map['cropSubCategory']??'',
      cropUnit: map['cropUnit'] ?? '',
      cropQuantity: map['cropQuantity'] ?? 0,
      cropQuality: map['cropQuality'] ?? '',
      cropImageURLs: List<String>.from(map['cropImageURLs'] ?? []),
      cropAskPrice: map['cropAskPrice'] ?? 0.0,
      cropDescription: map['cropDescription'] ?? '',
      cropRemarks: map['cropRemarks'],
      bidStartDate: map['bidStartDate']?.toDate() ?? DateTime.now(),
      bidEndDate: map['bidEndDate']?.toDate() ?? DateTime.now(),
      active: map['active'] ?? true,
      qualityInspectionRequest: map['qualityInspectionRequest'] ?? false,
      createdDate: map['createdDate']?.toDate() ?? DateTime.now(),
      submitDate: map['submitDate']?.toDate() ?? DateTime.now(),
      updateDate: map['updateDate']?.toDate() ?? DateTime.now(),
    );
  }
}
