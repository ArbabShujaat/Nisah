import 'dart:ui';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:servicesapp/Models/models.dart';
import 'package:servicesapp/complaint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Color textcolor = Color(0XFF993052);

class BookingDetails extends StatefulWidget {
  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  void _showRatingDialog(
      String sellerdocid, String sellerUid, int numberOfReviews, int rating) {
    // We use the built in showDialog function to show our Rating Dialog
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/gentle.jpg",
                      ),
                      fit: BoxFit.cover)),
            ),

            title: "Give Review to the Seller",
            description: "",
            submitButton: "SUBMIT",
            alternativeButton: "Contact us instead?",
            // optional
            positiveComment: "We are so happy to hear :)", // optional
            negativeComment: "We're sad to hear :(", // optional
            accentColor: textcolor, // optional
            onSubmitPressed: (int ratings) async {
              numberOfReviews = numberOfReviews + 1;
              print(rating);
              print(ratings);
              print(numberOfReviews);

              rating = ((ratings + rating) / numberOfReviews).floor();
              print(rating);

              await Firestore.instance
                  .collection("Sellers")
                  .document(sellerdocid)
                  .update({
                "Rating": rating,
                "numberOfReviews": numberOfReviews,
              });
              String sellerdocid2 = "";

              await Firestore.instance
                  .collection("ServiceRequest")
                  .where("sellerDocid", isEqualTo: sellerdocid)
                  .getDocuments()
                  .then((value) {
                sellerdocid2 = value.documents[0].documentID;
              });

              await Firestore.instance
                  .collection("ServiceRequest")
                  .document(sellerdocid2)
                  .update({"rated": true});
            },
            onAlternativePressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ComplaintScreen()));
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Booking Details"),
          backgroundColor: textcolor,
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Text(
                  "Pending Requests",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.white70),
                  height: MediaQuery.of(context).size.height * .41,
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: StreamBuilder(
                      stream: Firestore.instance
                          .collection("ServiceRequest")
                          .where("userUid", isEqualTo: userDetails.userUid)
                          .where("accepted", isEqualTo: false)
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
                          return ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.red,
                                thickness: 0.5,
                              );
                            },
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot bookingDetail =
                                  snapshot.data.documents[index];
                              return listitem(bookingDetail);
                            },
                          );
                        }
                      }),
                ),
                Text(
                  "Completed Orders",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.white70),
                  height: MediaQuery.of(context).size.height * .51,
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: StreamBuilder(
                      stream: Firestore.instance
                          .collection("ServiceRequest")
                          .where("userUid", isEqualTo: userDetails.userUid)
                          .where("completed", isEqualTo: true)
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
                          return ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.red,
                                thickness: 0.5,
                              );
                            },
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot bookingDetail =
                                  snapshot.data.documents[index];
                              return completedorderlist(bookingDetail);
                            },
                          );
                        }
                      }),
                ),
              ],
            )));
  }

  Widget completedorderlist(DocumentSnapshot bookingDetail) {
    return GestureDetector(
        onTap: () {
          if (bookingDetail["rated"] == false)
            _showRatingDialog(
                bookingDetail["sellerDocid"],
                bookingDetail["sellerUid"],
                bookingDetail["numberOfReviews"],
                bookingDetail["rating"]);
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(5.0)),
            // width: 400,
            // height: 175,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.all(7.0),
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    bookingDetail["sellerPic"],
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        // Text(
                        //   "Cost",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 17,
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "No.of Customers : " +
                                bookingDetail["NumberOfPerson"] +
                                "    ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        // Text(
                        //   bookingDetail["NumberOfPerson"],
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.w300,
                        //       fontSize: 22),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Service Type : " + bookingDetail["serviceType"],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            width: 65.0,
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bookingDetail["ServicePrice"],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ]),
            )));
  }

  Widget listitem(DocumentSnapshot bookingDetail) {
    return Container(
        decoration: BoxDecoration(
            color: textcolor, borderRadius: BorderRadius.circular(5.0)),
        // width: 400,
        // height: 175,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(7.0),
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            bookingDetail["sellerPic"],
                          ),
                          fit: BoxFit.cover)),
                ),
                // Text(
                //   "Cost",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 17,
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "No.of Customers : " +
                        bookingDetail["NumberOfPerson"] +
                        "    ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                // Text(
                //   bookingDetail["NumberOfPerson"],
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.w300,
                //       fontSize: 22),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Service Type : " + bookingDetail["serviceType"],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    width: 65.0,
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                bookingDetail["ServicePrice"],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ]),
        ));
  }
}
