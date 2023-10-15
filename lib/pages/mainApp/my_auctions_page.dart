import 'package:flutter/material.dart';

enum UserType { buyer, farmer }

class Auction {
  final String cropName;
  final List<Bid> bids;

  Auction({required this.cropName, required this.bids});
}

class Bid {
  final String buyerName;
  final String buyerLocation;
  final double amount;
  final bool acceptedByFarmer;
  final bool wonByBuyer; // Add a field to track if the bid is won by the buyer

  Bid({
    required this.buyerName,
    required this.buyerLocation,
    required this.amount,
    this.acceptedByFarmer = false,
    this.wonByBuyer = false, // Default to false
  });
}

class MyAuctionsPage extends StatefulWidget {
  final UserType userType;

  MyAuctionsPage({required this.userType});

  @override
  _MyAuctionsPageState createState() => _MyAuctionsPageState();
}

class _MyAuctionsPageState extends State<MyAuctionsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample static data for auctions
  final List<Auction> auctions = [
    Auction(
      cropName: "Tomatoes",
      bids: [
        Bid(buyerName: "Buyer 1", buyerLocation: "Location 1", amount: 20.0, acceptedByFarmer: true,wonByBuyer: true),
        Bid(buyerName: "Buyer 2", buyerLocation: "Location 2", amount: 22.0),
        Bid(buyerName: "Buyer 3", buyerLocation: "Location 3", amount: 18.0, acceptedByFarmer: true),
      ],
    ),
    Auction(
      cropName: "Apples",
      bids: [
        Bid(buyerName: "Buyer 4", buyerLocation: "Location 4", amount: 15.0),
        Bid(buyerName: "Buyer 5", buyerLocation: "Location 5", amount: 16.0),
        Bid(buyerName: "Buyer 6", buyerLocation: "Location 6", amount: 14.0, acceptedByFarmer: true),
      ],
    ),
  ];

  void makePayment(Auction auction) {
  // You can implement your payment logic here.
  // This is a placeholder function, so you need to replace it with your actual payment integration code.

  // For demonstration purposes, we'll show a dialog when the "Make Payment" button is pressed.
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Make Payment'),
        content: Text('Payment successful for ${auction.cropName}!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Auctions'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Bids'),

           if(widget.userType==UserType.buyer)
           Tab(text: 'Wins & Payments'),
           if(widget.userType==UserType.farmer)
           Tab(text: 'Delivery'),


          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Bids Tab
          _buildBidsTab(),

          // Wins & Payments Tab
          if(widget.userType==UserType.buyer)
          _buildWinsAndPaymentsTab(),
          if(widget.userType==UserType.farmer)
          _buildDeliveryTab()
        ],
      ),
    );
  }

  Widget _buildBidsTab() {
    return ListView.builder(
      itemCount: auctions.length,
      itemBuilder: (context, index) {
        final auction = auctions[index];
        final top5Bids = getTop5Bids(auction.bids);

        return Card(
          child: Column(
            children: [
              ListTile(
                title: Text('Crop Name: ${auction.cropName}'),
              ),
              Column(
                children: top5Bids.asMap().entries.map((entry) {
                  final index = entry.key;
                  final bid = entry.value;

                  if (widget.userType == UserType.buyer && !bid.acceptedByFarmer) {
                    return SizedBox.shrink();
                  }

                  return ListTile(
                    title: Text('Price: \$${bid.amount.toStringAsFixed(2)}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Farm Name: Farm XYZ'), // Replace with actual farm name
                        Text('Location: Farm Location'), // Replace with actual farm location
                      ],
                    ),
                    trailing: widget.userType == UserType.buyer
                        ? ElevatedButton(
                            onPressed: () => increaseBid(auction, index), // Implement your increaseBid function
                            child: Text('Increase Bid'),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () => acceptBid(auction, index),
                                child: Text('Accept'),
                              ),
                              SizedBox(width: 8.0),
                              ElevatedButton(
                                onPressed: () => rejectBid(auction, index),
                                child: Text('Reject'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWinsAndPaymentsTab() {
  // Filter auctions to get the ones won by the buyer
  final List<Auction> wonAuctions = auctions.where((auction) {
    return auction.bids.any((bid) => bid.wonByBuyer);
  }).toList();
  

  return ListView.builder(
    itemCount: wonAuctions.length,
    itemBuilder: (context, index) {
      final auction = wonAuctions[index];

      return Card(
  elevation: 4, // Add elevation for a shadow effect
  margin: EdgeInsets.all(16), // Add margin for spacing
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10), // Add rounded corners
  ),
  child: Container(
    padding: EdgeInsets.all(16), // Add padding for content spacing
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Crop Name: ${auction.cropName}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8), // Add spacing between elements
        Text(
          'Price: \$${auction.bids.firstWhere((bid) => bid.wonByBuyer).amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8), // Add spacing between elements
        Text(
          'Farm Name: Farm XYZ', // Replace with actual farm name
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8), // Add spacing between elements
        Text(
          'Location: Farm Location', // Replace with actual farm location
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 16), // Add spacing at the bottom
        ElevatedButton.icon(
          onPressed: () => makePayment(auction), // Implement your makePayment function
          icon: Icon(Icons.payment), // Add an icon
          label: Text('Make Payment'), // Button label
          style: ElevatedButton.styleFrom(
            primary: Colors.green, // Change button color
            onPrimary: Colors.white, // Change text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Add rounded corners for the button
            ),))
      ],
    ),
  ),
);

    },
  );
}


  List<Bid> getTop5Bids(List<Bid> bids) {
    bids.sort((a, b) => b.amount.compareTo(a.amount));
    return bids.take(5).toList();
  }

  void acceptBid(Auction auction, int bidIndex) {
    // Implement your logic to accept the bid here
    // You can update the auction's state or perform other actions
    print('Accepted bid ${auction.bids[bidIndex].buyerName}');
  }

  void rejectBid(Auction auction, int bidIndex) {
    // Implement your logic to reject the bid here
    // You can update the auction's state or perform other actions
    print('Rejected bid ${auction.bids[bidIndex].buyerName}');
  }

  void increaseBid(Auction auction, int bidIndex) {
    // Implement your logic to increase the bid here
    // You can update the bid amount or perform other actions
    print('Increased bid ${auction.bids[bidIndex].buyerName}');

    
  }
}
Widget _buildDeliveryTab() {
    return Center(
      child: Text(
        'Delivery of Crops',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

