import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Home.dart';
import '../nearbysellers.dart';

UserDetails userDetails;
List<UserDetails> listUserDetail = [];
List<UserDetails> supportersList = [];
String aboutUs;
String contactUs;

///User
class UserDetails {
  final String userEmail;
  final String latitude;
  final String longitude;
  final String userUid;
  final String address;
  bool notificationOpened;
  String firstname;
  bool taxiActive;
  String lastname;

  final String userDocid;
  final String gender;
  String number;

  UserDetails({
    @required this.userEmail,
    @required this.address,
    @required this.taxiActive,
    @required this.userDocid,
    @required this.userUid,
    @required this.latitude,
    @required this.notificationOpened,
    @required this.longitude,
    @required this.lastname,
    @required this.number,
    @required this.firstname,
    @required this.gender,
  });
}

SellerDetails sellerDetails;
List<SellerDetails> sellarDetailsList = [];

///Seller
class SellerDetails {
  final String sellerPic;
  final String userEmail;
  final String latitude;
  final String longitude;
  final int numberOfReviews;
  final int rating;
  final String userUid;
  final String address;
  final String serviceType;
  final String price1;
  final String price2;
  final String price3;
  final String price4;
  final String price6;
  final String price5;
  final String price7;
  final String description;

  final String firstname;
  final String lastname;

  final String userDocid;
  final String gender;
  final String number;

  SellerDetails({
    @required this.userEmail,
    @required this.description,
    @required this.numberOfReviews,
    @required this.rating,
    @required this.price1,
    @required this.sellerPic,
    @required this.price2,
    @required this.price3,
    @required this.serviceType,
    this.price4,
    this.price6,
    this.price7,
    this.price5,
    @required this.address,
    @required this.userDocid,
    @required this.userUid,
    @required this.latitude,
    @required this.longitude,
    @required this.lastname,
    @required this.number,
    @required this.firstname,
    @required this.gender,
  });
}

/////List Of prices
var item;
double totalDistance = 0;
double totalDistance2 = 0;

Future<void> getSellers() async {
  await Firestore.instance
      .collection("Sellers")
      .where("serviceType", isEqualTo: serviceType)
      .getDocuments()
      .then((value) {
    for (int i = 0; i < value.documents.length; i++) {
      for (int j = i + 1; j < value.documents.length; j++) {
        totalDistance = calculateDistance(
            userDetails.latitude,
            userDetails.longitude,
            value.documents[i]["Latitude"],
            value.documents[i]["Longitude"]);
        totalDistance2 = calculateDistance(
            userDetails.latitude,
            userDetails.longitude,
            value.documents[j]["Latitude"],
            value.documents[j]["Longitude"]);

        if (totalDistance > totalDistance2) {
          index = i;
        } else {
          index = j;
        }

        print(totalDistance);
        print(totalDistance2);
      }
    }
  });

//   if (seller["serviceType"] == "Makeup") {
//     sellerDetails = SellerDetails(
//         sellerPic: seller["profilePic"],
//         userEmail: seller["email"],
//         rating: seller["Rating"],
//         numberOfReviews: seller["numberOfReviews"],
//         price1: seller["bridalMakeUp"],
//         price2: seller["bridesmaidMakeUp"],
//         price3: seller["makeupLashes"],
//         price4: seller["makeup"],
//         serviceType: seller["serviceType"],
//         address: seller["email"],
//         description: seller["description"],
//         userDocid: seller.documentID,
//         userUid: seller["userUid"],
//         latitude: seller["Latitude"].toString(),
//         longitude: seller["Longitude"].toString(),
//         lastname: seller["lastName"],
//         number: seller["phoneNumber"],
//         firstname: seller["firstName"],
//         gender: seller["gender"]);

//     item = [
//       'Bridal makeup ' + sellerDetails.price1,
//       'Bridesmaid Makeup ' + sellerDetails.price2,
//       'Simple makeup with Lashes ' + sellerDetails.price3,
//       'Simple makeup without Lashes ' + sellerDetails.price4,
//     ];
//   }

//   if (seller["serviceType"] == "Hair Dressing") {
//     sellerDetails = SellerDetails(
//         sellerPic: seller["profilePic"],
//         userEmail: seller["email"],
//         rating: seller["Rating"],
//         numberOfReviews: seller["numberOfReviews"],
//         price1: seller["hairBridal"],
//         price2: seller["wigLines"],
//         price3: seller["wigInstallation"],
//         price5: seller["mediumBraiding"],
//         price4: seller["smallBraiding"],
//         price6: seller["largeBraiding"],
//         price7: seller["washAndBlowDraw"],
//         serviceType: seller["serviceType"],
//         address: seller["email"],
//         description: seller["description"],
//         userDocid: seller.documentID,
//         userUid: seller["userUid"],
//         latitude: seller["Latitude"].toString(),
//         longitude: seller["Longitude"].toString(),
//         lastname: seller["lastName"],
//         number: seller["phoneNumber"],
//         firstname: seller["firstName"],
//         gender: seller["gender"]);

//     item = [
//       'Bridal ' + sellerDetails.price1,
//       'Wig Lines ' + sellerDetails.price2,
//       'Wig Installation ' + sellerDetails.price3,
//       'Small Braiding ' + sellerDetails.price4,
//       'Medium Braiding ' + sellerDetails.price5,
//       'Large Braiding ' + sellerDetails.price6,
//       'Wash & Blow dry ' + sellerDetails.price7,
//     ];
//   }

//   if (seller["serviceType"] == "Massage service") {
//     sellerDetails = SellerDetails(
//         sellerPic: seller["profilePic"],
//         userEmail: seller["email"],
//         price1: seller["deepTissue"],
//         price2: seller["swedish"],
//         price3: seller["prenatal"],
//         rating: seller["Rating"],
//         numberOfReviews: seller["numberOfReviews"],
//         price4: seller["backneckshoukder"],
//         serviceType: seller["serviceType"],
//         address: seller["email"],
//         description: seller["description"],
//         userDocid: seller.documentID,
//         userUid: seller["userUid"],
//         latitude: seller["Latitude"].toString(),
//         longitude: seller["Longitude"].toString(),
//         lastname: seller["lastName"],
//         number: seller["phoneNumber"],
//         firstname: seller["firstName"],
//         gender: seller["gender"]);
//     item = [
//       'Deep Tissue Massage  ' + sellerDetails.price1,
//       'Swedish Massage ' + sellerDetails.price2,
//       'Pre-natal Massage ' + sellerDetails.price3,
//       'Back,Neck & Shoulders' + sellerDetails.price4,
//     ];
//   }

//   if (seller["serviceType"] == "Heena") {
//     sellerDetails = SellerDetails(
//         sellerPic: seller["profilePic"],
//         userEmail: seller["email"],
//         price1: seller["bridal"],
//         price2: seller["hands"],
//         price3: seller["handsAndLegs"],
//         serviceType: seller["serviceType"],
//         rating: seller["Rating"],
//         numberOfReviews: seller["numberOfReviews"],
//         address: seller["email"],
//         description: seller["description"],
//         userDocid: seller.documentID,
//         userUid: seller["userUid"],
//         latitude: seller["Latitude"].toString(),
//         longitude: seller["Longitude"].toString(),
//         lastname: seller["lastName"],
//         number: seller["phoneNumber"],
//         firstname: seller["firstName"],
//         gender: seller["gender"]);
//     item = [
//       'Bridal  ' + sellerDetails.price1,
//       'Hands ' + sellerDetails.price2,
//       'Hands & Legs ' + sellerDetails.price3,
//     ];
//   }
//   if (seller["serviceType"] == "Pedicure & Manicure") {
//     sellerDetails = SellerDetails(
//         sellerPic: seller["profilePic"],
//         userEmail: seller["email"],
//         price1: seller["meniCurePandG"],
//         rating: seller["Rating"],
//         numberOfReviews: seller["numberOfReviews"],
//         price2: seller["meniCureP"],
//         price3: seller["pediCurePandG"],
//         price4: seller["pediCureP"],
//         serviceType: seller["serviceType"],
//         address: seller["email"],
//         description: seller["description"],
//         userDocid: seller.documentID,
//         userUid: seller["userUid"],
//         latitude: seller["Latitude"].toString(),
//         longitude: seller["Longitude"].toString(),
//         lastname: seller["lastName"],
//         number: seller["phoneNumber"],
//         firstname: seller["firstName"],
//         gender: seller["gender"]);

//     item = [
//       'Manicure with Polish & Gel  ' + sellerDetails.price1,
//       'Manicure with Polish Only ' + sellerDetails.price2,
//       'Pedicure with Polish & Gel ' + sellerDetails.price3,
//       'Pedicure with Polish Only ' + sellerDetails.price4,
//     ];
//   }

//   if (seller["serviceType"] == "Photography") {
//     sellerDetails = SellerDetails(
//         sellerPic: seller["profilePic"],
//         userEmail: seller["email"],
//         price1: seller["wedding"],
//         price2: seller["individual"],
//         rating: seller["Rating"],
//         numberOfReviews: seller["numberOfReviews"],
//         price3: seller["family"],
//         price4: seller["commercial"],
//         serviceType: seller["serviceType"],
//         address: seller["email"],
//         description: seller["description"],
//         userDocid: seller.documentID,
//         userUid: seller["userUid"],
//         latitude: seller["Latitude"].toString(),
//         longitude: seller["Longitude"].toString(),
//         lastname: seller["lastName"],
//         number: seller["phoneNumber"],
//         firstname: seller["firstName"],
//         gender: seller["gender"]);

//     item = [
//       'Wedding  ' + sellerDetails.price1,
//       'Individual ' + sellerDetails.price2,
//       'Family ' + sellerDetails.price3,
//       'Commercial ' + sellerDetails.price4,
//     ];
//   }

//   if (seller["serviceType"] == "Taxi Services") {
//     sellerDetails = SellerDetails(
//         sellerPic: seller["profilePic"],
//         userEmail: seller["email"],
//         price1: seller["small"],
//         rating: seller["Rating"],
//         numberOfReviews: seller["numberOfReviews"],
//         price2: seller["eleven"],
//         price3: seller["carNormal"],
//         price4: seller["carBridal"],
//         serviceType: seller["serviceType"],
//         address: seller["email"],
//         description: seller["description"],
//         userDocid: seller.documentID,
//         userUid: seller["userUid"],
//         latitude: seller["Latitude"].toString(),
//         longitude: seller["Longitude"].toString(),
//         lastname: seller["lastName"],
//         number: seller["phoneNumber"],
//         firstname: seller["firstName"],
//         gender: seller["gender"]);

//     item = [
//       'Small  ' + sellerDetails.price1,
//       'XI ' + sellerDetails.price2,
//       'Car Hire Normal ' + sellerDetails.price3,
//       'Car Hire for Bridal ' + sellerDetails.price4,
//     ];
//   }

//   if (seller["serviceType"] == "Videography") {
//     sellerDetails = SellerDetails(
//         sellerPic: seller["profilePic"],
//         userEmail: seller["email"],
//         rating: seller["Rating"],
//         numberOfReviews: seller["numberOfReviews"],
//         price1: seller["vwedding"],
//         price2: seller["vindividual"],
//         price3: seller["vcommercial"],
//         serviceType: seller["serviceType"],
//         address: seller["email"],
//         description: seller["description"],
//         userDocid: seller.documentID,
//         userUid: seller["userUid"],
//         latitude: seller["Latitude"].toString(),
//         longitude: seller["Longitude"].toString(),
//         lastname: seller["lastName"],
//         number: seller["phoneNumber"],
//         firstname: seller["firstName"],
//         gender: seller["gender"]);

//     item = [
//       'Wedding  ' + sellerDetails.price1,
//       'Individual ' + sellerDetails.price2,
//       'Commercial ' + sellerDetails.price3,
//     ];
//   }
// }
}
