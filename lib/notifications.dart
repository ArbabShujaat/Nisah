import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:servicesapp/Models/models.dart';
import 'package:servicesapp/main.dart';

import 'maps.dart';

// DocumentSnapshot serviceDetailforTaxiMap;
double taxSellerLatitude;
double taxSellerLongitude;
final Color textcolorr = Color(0XFF993052);

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textcolorr,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: textcolorr,
        elevation: 0.0,
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("ServiceRequest")
              .where("userUid", isEqualTo: userDetails.userUid)
              .where("accepted", isEqualTo: true)
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
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot serviceDetail =
                        snapshot.data.documents[index];
                    return InkWell(
                      onTap: () async {
                        if (serviceDetail["serviceType"] == "Taxi Services" &&
                            serviceDetail["completed"] == false) {
                          taxisellerDocid = serviceDetail["sellerDocid"];

                          await Firestore.instance
                              .collection('Sellers')
                              .where("userUid",
                                  isEqualTo: serviceDetail["sellerUid"])
                              .getDocuments()
                              .then((value) => {
                                    taxSellerLatitude =
                                        value.documents[0]["Latitude"],
                                    taxSellerLongitude =
                                        value.documents[0]["Longitude"],
                                  });

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MapPage()));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border.all(color: Colors.red, width: 1)),
                        child: ListTile(
                          subtitle: Text("Date of service : " +
                              DateFormat('EEE, M/d/y').format(
                                  DateTime.parse(serviceDetail["DateTime"]))),
                          trailing: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: serviceDetail["serviceType"] ==
                                            "Makeup"
                                        ? new AssetImage("assets/one.jpg")
                                        : serviceDetail["serviceType"] ==
                                                "Hair Dressing"
                                            ? new AssetImage("assets/two.jpg")
                                            : serviceDetail["serviceType"] ==
                                                    "Massage service"
                                                ? new AssetImage(
                                                    "assets/three.jpg")
                                                : serviceDetail[
                                                            "serviceType"] ==
                                                        "Heena"
                                                    ? new AssetImage(
                                                        "assets/four.jpg")
                                                    : serviceDetail[
                                                                "serviceType"] ==
                                                            "Pedicure & Manicure"
                                                        ? new AssetImage(
                                                            "assets/five.jpg")
                                                        : serviceDetail[
                                                                    "serviceType"] ==
                                                                "Photography"
                                                            ? new AssetImage(
                                                                "assets/six.jpg")
                                                            : serviceDetail[
                                                                        "serviceType"] ==
                                                                    "Taxi Services"
                                                                ? new AssetImage(
                                                                    "assets/seven.jpg")
                                                                : new AssetImage(
                                                                    "assets/eight.jpg"))),
                          ),
                          leading: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(
                                        serviceDetail["sellerPic"]))),
                          ),
                          title: Text(
                            serviceDetail["sellerName"] +
                                " accepted your service request",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
