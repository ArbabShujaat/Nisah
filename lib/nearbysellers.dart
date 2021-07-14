import 'dart:math';

import 'package:servicesapp/Profile.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

import 'Home.dart';
import 'Models/models.dart';

int index = 0;
final Color textcolorr = Color(0XFF993052);

class NearbySellerScreen extends StatefulWidget {
  @override
  _NearbySellerState createState() => _NearbySellerState();
}

class _NearbySellerState extends State<NearbySellerScreen> {
  var rating = 3.0;
  int _n = 0;
  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: textcolorr,
            title: Row(
              children: [
                Text("Nearby to you"),
                Icon(Icons.near_me_outlined),
              ],
            )),
        body: new StreamBuilder(
            stream: Firestore.instance
                .collection("Sellers")
                .where("approved", isEqualTo: true)
                .where("serviceType", isEqualTo: serviceType)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                // return Center(
                //   child: Text(
                //     'NO SELLERS YET',
                //   ),
                // );
                return Center(child: CircularProgressIndicator());
              } else {
                return new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, i) {
                      // if (snapshot.data.documents.length > 2)
                      //   for (int j = i + 1;
                      //       j < snapshot.data.documents.length;
                      //       j++) {
                      //     totalDistance = calculateDistance(
                      //         double.parse(userDetails.latitude),
                      //         double.parse(userDetails.longitude),
                      //         snapshot.data.documents[i]["Latitude"],
                      //         snapshot.data.documents[i]["Longitude"]);
                      //     totalDistance2 = calculateDistance(
                      //         double.parse(userDetails.latitude),
                      //         double.parse(userDetails.longitude),
                      //         snapshot.data.documents[j]["Latitude"],
                      //         snapshot.data.documents[j]["Longitude"]);

                      //     if (totalDistance < totalDistance2) {
                      //       index = j;
                      //     } else {
                      //       index = i;
                      //     }

                      //     print(totalDistance);
                      //     print(totalDistance2);
                      //   }
                      // else {
                      //   index = i;
                      // }

                      DocumentSnapshot seller = snapshot.data.documents[i];
                      var distance = calculateDistance(
                          double.parse(userDetails.latitude),
                          double.parse(userDetails.longitude),
                          snapshot.data.documents[i]["Latitude"],
                          snapshot.data.documents[i]["Longitude"]);
                      print(distance);

                      if (snapshot.data.documents.length == 0) {}

                      return Container(
                        padding: EdgeInsets.all(10.0),
                        height: 230,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  1.0, // Move to right 10  horizontally
                                  1.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: textcolorr),
                        margin: EdgeInsets.all(20.0),
                        child: ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        scale: 2.0,
                                        image: NetworkImage(
                                          seller["profilePic"],
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SmoothStarRating(
                                              //  rating: 1.0,
                                              rating: seller["Rating"] + 0.0,
                                              allowHalfRating: false,
                                              onRated: (v) {},
                                              starCount: 5,
                                              size: 20.0,
                                              isReadOnly: true,
                                              color: Colors.yellow,
                                              borderColor: Colors.yellow,
                                              spacing: 1.0),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                getSellerInformation(seller);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));
                                              },
                                              child: Text(
                                                "View Profile",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Row(
                                //   children: [
                                //     Text(
                                //       "Estimated Distance: ",
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 18),
                                //     ),
                                //     Text(
                                //       distance.round().toString(),
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 16),
                                //     ),
                                //   ],
                                // ),
                                // Column(
                                //   children: [
                                //     Text(
                                //       "Starting Pricing",
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 18),
                                //     ),
                                //     Text(
                                //       "KES 15,000",
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 16),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 10.0),
                              child: Text(
                                seller["firstName"] + " " + seller["lastName"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Icon(
                                      Icons.call,
                                      size: 40.0,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      seller["phoneNumber"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                              width: 20.0,
                            ),
                          ],
                        ),
                      );
                    });
              }
            }));
  }

  void getSellerInformation(DocumentSnapshot seller) {
    if (seller["serviceType"] == "Makeup") {
      sellerDetails = SellerDetails(
          sellerPic: seller["profilePic"],
          userEmail: seller["email"],
          rating: seller["Rating"],
          numberOfReviews: seller["numberOfReviews"],
          price1: seller["bridalMakeUp"],
          price2: seller["bridesmaidMakeUp"],
          price3: seller["makeupLashes"],
          price4: seller["makeup"],
          serviceType: seller["serviceType"],
          address: seller["email"],
          description: seller["description"],
          userDocid: seller.documentID,
          userUid: seller["userUid"],
          latitude: seller["Latitude"].toString(),
          longitude: seller["Longitude"].toString(),
          lastname: seller["lastName"],
          number: seller["phoneNumber"],
          firstname: seller["firstName"],
          gender: seller["gender"]);

      item = [
        'Bridal makeup ' + sellerDetails.price1,
        'Bridesmaid Makeup ' + sellerDetails.price2,
        'Simple makeup with Lashes ' + sellerDetails.price3,
        'Simple makeup without Lashes ' + sellerDetails.price4,
      ];
    }

    if (seller["serviceType"] == "Hair Dressing") {
      sellerDetails = SellerDetails(
          sellerPic: seller["profilePic"],
          userEmail: seller["email"],
          rating: seller["Rating"],
          numberOfReviews: seller["numberOfReviews"],
          price1: seller["hairBridal"],
          price2: seller["wigLines"],
          price3: seller["wigInstallation"],
          price5: seller["mediumBraiding"],
          price4: seller["smallBraiding"],
          price6: seller["largeBraiding"],
          price7: seller["washAndBlowDraw"],
          serviceType: seller["serviceType"],
          address: seller["email"],
          description: seller["description"],
          userDocid: seller.documentID,
          userUid: seller["userUid"],
          latitude: seller["Latitude"].toString(),
          longitude: seller["Longitude"].toString(),
          lastname: seller["lastName"],
          number: seller["phoneNumber"],
          firstname: seller["firstName"],
          gender: seller["gender"]);

      item = [
        'Bridal ' + sellerDetails.price1,
        'Wig Lines ' + sellerDetails.price2,
        'Wig Installation ' + sellerDetails.price3,
        'Small Braiding ' + sellerDetails.price4,
        'Medium Braiding ' + sellerDetails.price5,
        'Large Braiding ' + sellerDetails.price6,
        'Wash & Blow dry ' + sellerDetails.price7,
      ];
    }

    if (seller["serviceType"] == "Massage service") {
      sellerDetails = SellerDetails(
          sellerPic: seller["profilePic"],
          userEmail: seller["email"],
          price1: seller["deepTissue"],
          price2: seller["swedish"],
          price3: seller["prenatal"],
          rating: seller["Rating"],
          numberOfReviews: seller["numberOfReviews"],
          price4: seller["backneckshoukder"],
          serviceType: seller["serviceType"],
          address: seller["email"],
          description: seller["description"],
          userDocid: seller.documentID,
          userUid: seller["userUid"],
          latitude: seller["Latitude"].toString(),
          longitude: seller["Longitude"].toString(),
          lastname: seller["lastName"],
          number: seller["phoneNumber"],
          firstname: seller["firstName"],
          gender: seller["gender"]);
      item = [
        'Deep Tissue Massage  ' + sellerDetails.price1,
        'Swedish Massage ' + sellerDetails.price2,
        'Pre-natal Massage ' + sellerDetails.price3,
        'Back,Neck & Shoulders' + sellerDetails.price4,
      ];
    }

    if (seller["serviceType"] == "Heena") {
      sellerDetails = SellerDetails(
          sellerPic: seller["profilePic"],
          userEmail: seller["email"],
          price1: seller["bridal"],
          price2: seller["hands"],
          price3: seller["handsAndLegs"],
          serviceType: seller["serviceType"],
          rating: seller["Rating"],
          numberOfReviews: seller["numberOfReviews"],
          address: seller["email"],
          description: seller["description"],
          userDocid: seller.documentID,
          userUid: seller["userUid"],
          latitude: seller["Latitude"].toString(),
          longitude: seller["Longitude"].toString(),
          lastname: seller["lastName"],
          number: seller["phoneNumber"],
          firstname: seller["firstName"],
          gender: seller["gender"]);
      item = [
        'Bridal  ' + sellerDetails.price1,
        'Hands ' + sellerDetails.price2,
        'Hands & Legs ' + sellerDetails.price3,
      ];
    }
    if (seller["serviceType"] == "Pedicure & Manicure") {
      sellerDetails = SellerDetails(
          sellerPic: seller["profilePic"],
          userEmail: seller["email"],
          price1: seller["meniCurePandG"],
          rating: seller["Rating"],
          numberOfReviews: seller["numberOfReviews"],
          price2: seller["meniCureP"],
          price3: seller["pediCurePandG"],
          price4: seller["pediCureP"],
          serviceType: seller["serviceType"],
          address: seller["email"],
          description: seller["description"],
          userDocid: seller.documentID,
          userUid: seller["userUid"],
          latitude: seller["Latitude"].toString(),
          longitude: seller["Longitude"].toString(),
          lastname: seller["lastName"],
          number: seller["phoneNumber"],
          firstname: seller["firstName"],
          gender: seller["gender"]);

      item = [
        'Manicure with Polish & Gel  ' + sellerDetails.price1,
        'Manicure with Polish Only ' + sellerDetails.price2,
        'Pedicure with Polish & Gel ' + sellerDetails.price3,
        'Pedicure with Polish Only ' + sellerDetails.price4,
      ];
    }

    if (seller["serviceType"] == "Photography") {
      sellerDetails = SellerDetails(
          sellerPic: seller["profilePic"],
          userEmail: seller["email"],
          price1: seller["wedding"],
          price2: seller["individual"],
          rating: seller["Rating"],
          numberOfReviews: seller["numberOfReviews"],
          price3: seller["family"],
          price4: seller["commercial"],
          serviceType: seller["serviceType"],
          address: seller["email"],
          description: seller["description"],
          userDocid: seller.documentID,
          userUid: seller["userUid"],
          latitude: seller["Latitude"].toString(),
          longitude: seller["Longitude"].toString(),
          lastname: seller["lastName"],
          number: seller["phoneNumber"],
          firstname: seller["firstName"],
          gender: seller["gender"]);

      item = [
        'Wedding  ' + sellerDetails.price1,
        'Individual ' + sellerDetails.price2,
        'Family ' + sellerDetails.price3,
        'Commercial ' + sellerDetails.price4,
      ];
    }

    if (seller["serviceType"] == "Taxi Services") {
      sellerDetails = SellerDetails(
          sellerPic: seller["profilePic"],
          userEmail: seller["email"],
          price1: seller["small"],
          rating: seller["Rating"],
          numberOfReviews: seller["numberOfReviews"],
          price2: seller["eleven"],
          price3: seller["carNormal"],
          price4: seller["carBridal"],
          serviceType: seller["serviceType"],
          address: seller["email"],
          description: seller["description"],
          userDocid: seller.documentID,
          userUid: seller["userUid"],
          latitude: seller["Latitude"].toString(),
          longitude: seller["Longitude"].toString(),
          lastname: seller["lastName"],
          number: seller["phoneNumber"],
          firstname: seller["firstName"],
          gender: seller["gender"]);

      item = [
        'Small  ' + sellerDetails.price1,
        'XI ' + sellerDetails.price2,
        'Car Hire Normal ' + sellerDetails.price3,
        'Car Hire for Bridal ' + sellerDetails.price4,
      ];
    }

    if (seller["serviceType"] == "Videography") {
      sellerDetails = SellerDetails(
          sellerPic: seller["profilePic"],
          userEmail: seller["email"],
          rating: seller["Rating"],
          numberOfReviews: seller["numberOfReviews"],
          price1: seller["vwedding"],
          price2: seller["vindividual"],
          price3: seller["vcommercial"],
          serviceType: seller["serviceType"],
          address: seller["email"],
          description: seller["description"],
          userDocid: seller.documentID,
          userUid: seller["userUid"],
          latitude: seller["Latitude"].toString(),
          longitude: seller["Longitude"].toString(),
          lastname: seller["lastName"],
          number: seller["phoneNumber"],
          firstname: seller["firstName"],
          gender: seller["gender"]);

      item = [
        'Wedding  ' + sellerDetails.price1,
        'Individual ' + sellerDetails.price2,
        'Commercial ' + sellerDetails.price3,
      ];
    }
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
