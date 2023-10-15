import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:agrimart/pages/mainApp/crops_details_page.dart';
import 'package:agrimart/models/crop_info.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CropCard extends StatefulWidget {
  final Crop crop;

  CropCard({required this.crop});

  @override
  _CropCardState createState() => _CropCardState();
}

class _CropCardState extends State<CropCard> {
  late Timer _timer;
  late String remainingTime = '';
  bool isFavorite = false; // Initialize as not favorited

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = getRemainingTime();
      });
    });
  }

  String getRemainingTime() {
    final currentTime = DateTime.now();
    final isBidNotStarted = currentTime.isBefore(widget.crop.bidStartDate);
    final isBidCompleted = currentTime.isAfter(widget.crop.bidEndDate);

    if (isBidNotStarted) {
      final timeToStart = widget.crop.bidStartDate.difference(currentTime);
      final days = timeToStart.inDays;
      final hours = timeToStart.inHours.remainder(24);
      final minutes = timeToStart.inMinutes.remainder(60);
      if (days > 0) {
        return 'Bid Starts in $days days $hours h $minutes m';
      } else {
        return 'Bid Starts in $hours h $minutes m';
      }
    } else if (!isBidCompleted) {
      final timeToEnd = widget.crop.bidEndDate.difference(currentTime);
      final days = timeToEnd.inDays;
      final hours = timeToEnd.inHours.remainder(24);
      final minutes = timeToEnd.inMinutes.remainder(60);
      if (days > 0) {
        return 'Bid Ends in $days days ';
      } else {
        return 'Bid Ends in $hours h $minutes m';
      }
    } else {
      return 'Bidding Ended';
    }
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    // TODO: Update user's favorite status in your data storage here
    // You can use a database or a state management solution to manage favorites
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _navigateToCropDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CropsDetailPage(
          remainingTime: remainingTime,
          crop: widget.crop, // Pass the cropInfo to CropsDetailPage
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final maxCropNameLength = 15; // Adjust the maximum length as needed

    String truncatedCropName = widget.crop.cropName.length <= maxCropNameLength
        ? widget.crop.cropName
        : '${widget.crop.cropName.substring(0, maxCropNameLength)}...';

    return GestureDetector(
      onTap: () {
        _navigateToCropDetail();
      },
      child: AspectRatio(
        aspectRatio: 1.0, // Adjust the aspect ratio as needed
        child: Card(
          elevation: 4.0,
          margin: EdgeInsets.only(top: 8.0, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Align(
      alignment: Alignment.center,
      widthFactor: 0.5, // Adjust this factor to control the width of the center portion
      heightFactor: 0.5, // Adjust this factor to control the height of the center portion
      child: CachedNetworkImage( // Use CachedNetworkImage here
      imageUrl: widget.crop.cropImageURLs[0], // Firebase Storage URL
      fit: BoxFit.cover,
      placeholder: (context, url) => CircularProgressIndicator(), // Placeholder widget
      errorWidget: (context, url, error) => Icon(Icons.error), // Error widget
    ),
  
    ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      truncatedCropName,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite // Show filled heart icon when favorited
                            : Icons.favorite_border, // Show outlined heart icon when not favorited
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: toggleFavorite,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  remainingTime, // Display remaining time
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              if (remainingTime == 'Bidding Ended')
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Sold at: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black, // "Current Bid" text color
                          ),
                        ),
                        TextSpan(
                          text: '\$${widget.crop.cropAskPrice}',
                          style: const TextStyle(
                            fontSize: 24.0, // Adjust the font size as needed
                            fontWeight: FontWeight.bold,
                            color: Colors.green, // Bid price text color
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (remainingTime.startsWith('Bid Starts'))
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'ASK price',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black, // "Current Bid" text color
                          ),
                        ),
                        TextSpan(
                          text: '\$${widget.crop.cropAskPrice}',
                          style: TextStyle(
                            fontSize: 24.0, // Adjust the font size as needed
                            fontWeight: FontWeight.bold,
                            color: Colors.red, // Bid price text color
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (remainingTime.startsWith("Bid Ends"))
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Current Bid: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black, // "Current Bid" text color
                          ),
                        ),
                        TextSpan(
                          text: '\$${widget.crop.cropAskPrice}',
                          style: TextStyle(
                            fontSize: 24.0, // Adjust the font size as needed
                            fontWeight: FontWeight.bold,
                            color: Colors.red, // Bid price text color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
