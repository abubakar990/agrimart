import 'package:agrimart/const/colors.dart';

import 'package:agrimart/const/fonts.dart';
import 'package:agrimart/pages/farmer/Crop/add_crop_page.dart';
import 'package:agrimart/pages/farmer/Crop/my_crops_page.dart';
import 'package:agrimart/provider/auth_provider.dart';
import 'package:agrimart/provider/crops_provider.dart';
import 'package:agrimart/widgets/dashboard_buttons.dart';
import 'package:agrimart/widgets/temperature_view_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../widgets/farmer_dashboard_drawer.dart';

class FarmersDashboard extends StatefulWidget {
  

  FarmersDashboard({super.key, 
   
  });
  

  @override
  State<FarmersDashboard> createState() => _FarmersDashboardState();
}

class _FarmersDashboardState extends State<FarmersDashboard> {
  //CropController _cropController = CropController();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  bool isBalanceVisible = true;
  bool isPendingBalanceVisible = true;

 
  void toggleBalanceVisibility() {
    setState(() {
      isBalanceVisible = !isBalanceVisible;
    });
  }
  void togglePendingBalanceVisibility() {
    setState(() {
      isPendingBalanceVisible = !isPendingBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final authProvider = Provider.of<AuthProvider>(context);
    final userData = authProvider.userData;

    if (userData == null) {
      // Handle the case where user data is not available
      return CircularProgressIndicator(); // or any other loading indicator
    }
    

    final farmerName = userData['firstName'];
   final profilePictureUrl = userData['userProfilePic'];
   print(profilePictureUrl);
    final farmerEmail = userData['email'] ?? ""; // Replace with the actual field name
   var height = MediaQuery.of(context).size.height;
   var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 200, 200),
      
      body: SingleChildScrollView(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: height * 0.2,
                  color: appMainColor,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello,  $farmerName",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "Its Sunny Today",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        if(profilePictureUrl!=null)
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:NetworkImage(profilePictureUrl),
                        
                        ),
                        if(profilePictureUrl==null)
                        CircleAvatar(
                          radius: 40,
                          //backgroundImage:AssetImage(Icons.person)),
                        
                        ),
                      ],
                    ),
                  ),
                ),
                 
                 Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.15,left: width * 0.06,),
                      child: Container(
                        width: width * 0.88,
                        height: height * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 5,spreadRadius:2,offset: Offset(0, 3))],
                          
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: height*0.1, // Adjust the height as needed
                          ),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return TemperatureViewWidget(
                                widgetMainColor: Colors.green,
                                widgetIcon: Icon(Icons.thermostat, size: 30, color: Colors.white),
                               // iconColor: Colors.green,
                                mainWidgetText: "40 °C",
                                subWidgetText: "Temperature",
                              );
                            } else if (index == 1) {
                              return TemperatureViewWidget(
                                widgetMainColor: Colors.blue,
                                widgetIcon: Icon(Icons.pin_drop_outlined, size: 30, color: Colors.white),
                                //iconColor: Colors.blue,
                                mainWidgetText: "20 %",
                                subWidgetText: "Humidity",
                              );
                            } else if (index == 2) {
                              return TemperatureViewWidget(
                                widgetMainColor: Colors.purple,
                                widgetIcon: Icon(Icons.cloud, size: 30, color: Colors.white),
                                //iconColor: Colors.purple,
                                mainWidgetText: "1.5 mm",
                                subWidgetText: "Rainfall",
                              );
                            } else {
                              return TemperatureViewWidget(
                                widgetMainColor: Colors.amber,
                                widgetIcon: Icon(Icons.air, size: 30, color: Colors.white),
                               // iconColor: Colors.amber,
                                mainWidgetText: "5 km/h",
                                subWidgetText: "WindSpeed",
                              );
                            }
                          },
                          itemCount: 4, // Number of grid items
                        ),
                        )
      ,))]
                       
                      ),
                    
                  ],
                  
                
                 ),
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Container(
                    height: height*0.05,
                   // width: width*0.95,
                    //color: appMainColor,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                          GestureDetector(
                            onTap: toggleBalanceVisibility,
                            child: Text("Balance: ${isBalanceVisible ? '****' : '10 M'}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                            GestureDetector(
                            onTap: togglePendingBalanceVisibility,
                          child: Text("Pending Balance: ${isPendingBalanceVisible ? '****' : '1 M'}" ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),))
                         ],
                        ),
                        Divider(color: Colors.black,),
                         
                      ],
                    ),
                   ),
                 ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   Consumer<CropsProvider>(
                  builder: (context, cropsProvider, child) {
                    final authProvider = Provider.of<AuthProvider>(context);
                    final availableCropsCount =
                        cropsProvider.getCropCountForFarmer(authProvider.user?.uid ?? "");

                    return DashboardButtons(
                      name: "Available Crops",
                      number: availableCropsCount,
                      backgroundColor: const Color.fromARGB(255, 252, 76, 64),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCropsPage())),
                    );
                  },
                ),

                 Consumer<CropsProvider>(
                  builder: (context, cropsProvider, child) {
                    final authProvider = Provider.of<AuthProvider>(context);
                    final availableCropsCount =
                        cropsProvider.getCropCountForFarmer(authProvider.user?.uid ?? "");

                    return DashboardButtons(
                      name: "Upcomming Bids",
                      number: availableCropsCount,
                      backgroundColor: const Color.fromARGB(255, 241, 184, 28),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCropsPage())),
                    );
                  },
                ),
              
            
                 //DashboardButtons(name: "Upcomming Bids",number: "4",backgroundColor: Color.fromARGB(255, 241, 184, 28),)
                 ],
      
                 ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       Consumer<CropsProvider>(
                  builder: (context, cropsProvider, child) {
                    final authProvider = Provider.of<AuthProvider>(context);
                    final availableCropsCount =
                        cropsProvider.getCropCountForFarmer(authProvider.user?.uid ?? "");

                    return DashboardButtons(
                      name: "Pending Bids",
                      number: availableCropsCount,
                      backgroundColor:Colors.blue,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCropsPage())),
                    );
                  },
                ),
                 Consumer<CropsProvider>(
                  builder: (context, cropsProvider, child) {
                    final authProvider = Provider.of<AuthProvider>(context);
                    final availableCropsCount =
                        cropsProvider.getCropCountForFarmer(authProvider.user?.uid ?? "");

                    return DashboardButtons(
                      name: "Completed Bids",
                      number: availableCropsCount,
                      backgroundColor: Colors.green,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCropsPage())),
                    );
                  },
                ),
                      // DashboardButtons(name: "Pending Bids",number: "6",backgroundColor:Colors.blue),
                                // DashboardButtons(name: "Completed Bids",number: "100",backgroundColor: Colors.green)
                                ],
                                 
                                 ),
                  ),
                
                
                 SizedBox(height: height*0.1)
              ],
            ),
      
      ),
          
         
    floatingActionButton:ElevatedButton(
  onPressed: () {
    Navigator.of(context).push(MaterialPageRoute(builder:(context) =>AddCropPage() ));
  },
  style: ElevatedButton.styleFrom(
    primary: appMainColor, // Set the button's background color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Add rounded corners
    ),
    elevation: 4.0, // Add a subtle shadow
    minimumSize: Size(width*0.9, height*0.07), // Set the button's minimum size
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.add, color: Colors.white,size: 30,), // Set the icon color to white
      SizedBox(width: 8.0), // Add some spacing between icon and text
      Text(
        "Add Crop for Auction",
        style: TextStyle(
          color: Colors.white, // Set the text color to white
          fontWeight: FontWeight.bold,
          fontSize: 18 // Make the text bold
        ),
      ),
    ],
  ),
)


    );
  }
}


