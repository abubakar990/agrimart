import 'package:agrimart/const/colors.dart';
import 'package:agrimart/pages/mainApp/chat/chat_page.dart';
import 'package:agrimart/provider/auth_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:agrimart/models/crop_info.dart';
import 'package:provider/provider.dart';

class CropsDetailPage extends StatefulWidget {
  final String remainingTime;
  final Crop crop;

  CropsDetailPage({required this.remainingTime, required this.crop});

  @override
  _CropsDetailPageState createState() => _CropsDetailPageState();
}

class _CropsDetailPageState extends State<CropsDetailPage> {
  TextEditingController bidController = TextEditingController();
  int currentBidAmount = 100; // Initialize with the current bid amount

  @override
  void dispose() {
    bidController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = AuthProvider();
    var userRole = authProvider.userData?['userType'];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print("$userRole");

    return GestureDetector(
      onTap: () {
        // Close the keyboard when tapping outside of text fields.
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crop Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                var userRole = authProvider.userData?['userType'];
                String farmerName= authProvider.userData?['firstName'];
                print("$userRole");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: height * 0.2,
                      enlargeCenterPage: true,
                      autoPlay: false,
                    ),
                    items: widget.crop.cropImageURLs.map((imageUrl) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage( // Use CachedNetworkImage here
        imageUrl: imageUrl,
        placeholder: (context, url) => CircularProgressIndicator(), // Placeholder widget while loading
        errorWidget: (context, url, error) => Icon(Icons.error), // Error widget if image fails to load
        width: width * 0.8,
        fit: BoxFit.cover,
      ),
                      );
                    }).toList(),
                  ),
                  Text(
                    widget.crop.cropName,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Current Bid: ${currentBidAmount.toString()}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  
                  if(userRole=='Buyer')
                  
                      buildBiddingWidget(context),
                  
                  
                        const Divider(),
                        const Text(
                          "Description",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          widget.crop.cropDescription,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: 40.0,
                                      // You can replace this URL with the actual profile picture URL
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                         Text('Farmer Name',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Farm Name',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 16.0,
                                              ),
                                              Text(
                                                '4.5',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        color: appMainColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.store,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  'About:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: width,
                                  child: const Text(
                                    'I am an experienced and dedicated farmer with a passion for cultivating high-quality crops. With years of farming expertise, they have established Farm Name as a hub of agricultural excellence. Farmer Name is known for their commitment to sustainable and eco-friendly farming practices, ensuring the freshest and healthiest produce for their customers. They have received excellent ratings and reviews from satisfied buyers for their top-notch crops and outstanding service.',
            
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                    maxLines: 5,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                               
                              ],
                            ),
                          ),
                        ),
                         const Divider(),
                                const Text(
                                  'Reviews and Ratings',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                
                        // You can add a list of reviews and ratings here
                                // Example:
                                buildReviewItem('Buyer Name', 'Great, got same quality', 4.5),
                                buildReviewItem('Buyer Name', 'Great, got same quality', 5.0),
                                // ...
                      ],
                    );}
            ),
                ),
              
            
          
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatScreen(crop: widget.crop,)));
          },
          child: const Icon(
            Icons.chat,
            size: 30,
          ),
        ),
      ),
    );
  }
 
Widget buildBiddingWidget(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '$currentBidAmount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          const Text(
            '+',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentBidAmount += 10;
                bidController.text = currentBidAmount.toString();
              });
            },
            child: const Text(
              '10',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                width: width,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(appMainColor),
                  ),
                  onPressed: () {
                    int newBidAmount = int.parse(bidController.text);
                    setState(() {
                      currentBidAmount = newBidAmount;
                    });
                  },
                  child: const Text(
                    'Bid on Crop',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            // ... other widgets ...
          ],
        ),
      ),
    ],
  );
}

  Widget buildReviewItem(String buyerName, String review, double rating) {
    return ListTile(
      leading:  const CircleAvatar(),
      title: Text(buyerName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(review),
          Row(
            children: [
             

              const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 16.0,
              ),
              Text(
                rating.toString(),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
