import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:servicesapp/Editprofile..dart';
import 'package:servicesapp/Models/models.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Proceedtocart.dart';

// final Color Colors.white = Color(0XFF993052);
final Color textcolour2 = Color(0XFF993052);

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _controller = new TextEditingController();
  int _n = 0;
  String selectedPrice = " Select $serviceType categories";
  String dateTime = "";
  bool buttonLoading = false;
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
        backgroundColor: textcolour2,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: textcolour2),
          title: Text(
            "About",
            style: TextStyle(color: textcolour2),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 120.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 170,
                      width: 170,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                sellerDetails.sellerPic,
                              ),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description:",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        Text(
                          sellerDetails.description,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 18),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "About me:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  child: Text(
                    sellerDetails.firstname + " " + sellerDetails.lastname,
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
                          sellerDetails.number,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: SmoothStarRating(
                          rating: sellerDetails.rating + 0.0,
                          allowHalfRating: false,
                          onRated: (v) {},
                          starCount: 5,
                          size: 25.0,
                          isReadOnly: true,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                          spacing: 1.0),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Email: " + sellerDetails.userEmail,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: new Theme(
                          data: new ThemeData(
                            primaryColor: textcolour2,
                            primaryColorDark: textcolour2,
                          ),
                          child: TextField(
                            readOnly: true,
                            // controller: _controller,
                            decoration: InputDecoration(
                              hintText: selectedPrice,
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: textcolour2,
                              ),
                              suffixIcon: PopupMenuButton<String>(
                                icon: const Icon(Icons.arrow_drop_down),
                                onSelected: (String value) {
                                  // _controller.text = value;
                                  setState(() {
                                    print("Hii");
                                    selectedPrice = value;
                                    value = selectedPrice;
                                    print(selectedPrice);
                                  });
                                },
                                itemBuilder: (BuildContext context) {
                                  return item.map<PopupMenuItem<String>>(
                                      (String value) {
                                    return new PopupMenuItem(
                                        child: new Text(
                                          value + " - KES",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: textcolour2,
                                          ),
                                        ),
                                        value: value + " - KES");
                                  }).toList();
                                },
                              ),
                            ),
                          )),
                    )),
                // Padding(
                //     padding: EdgeInsets.all(8.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Text(
                //           "Selected Price:",
                //           style: TextStyle(
                //               color: Colors.white,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 20),
                //         ),
                //         SizedBox(
                //           width: 5.0,
                //         ),
                //         Text(
                //           "KES - " + selectedPrice,
                //           style: TextStyle(color: Colors.white, fontSize: 18),
                //         ),
                //       ],
                //     )),

                Container(
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.all(10.0),
                    width: 500,
                    height: 140,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Text(
                              "No.of Customers",
                              style: TextStyle(
                                  color: textcolour2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            IconButton(
                                icon: Icon(Icons.add_circle_outline_rounded,
                                    color: textcolour2),
                                onPressed: add),
                            Text(
                              "$_n",
                              style: TextStyle(
                                  color: textcolour2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline,
                                  color: textcolour2),
                              onPressed: minus,
                            )
                          ],
                        ),
                        Theme(
                          data: ThemeData(
                            primarySwatch: Colors.pink,
                            splashColor: Colors.pink,
                          ),
                          child: DateTimePicker(
                            type: DateTimePickerType.dateTimeSeparate,
                            dateMask: 'd MMM, yyyy',
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: Icon(
                              Icons.event,
                              color: textcolour2,
                            ),
                            cursorColor: textcolour2,
                            dateLabelText: 'Date',
                            timeLabelText: 'Hour',
                            selectableDayPredicate: (date) {
                              // Disable weekend days to select from the calendar
                              // if (date.weekday == 6 || date.weekday == 7) {
                              //   return false;
                              // }

                              return true;
                            },
                            onChanged: (val) {
                              setState(() {
                                dateTime = val;
                              });
                            },
                            validator: (val) {
                              print(val);
                              setState(() {
                                dateTime = val;
                              });
                              print(dateTime);
                              return null;
                            },
                            onSaved: (val) => print(val),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height: 50,
                      minWidth: 250,
                      onPressed: () async {
                        print("hii1");
                        print(_n);
                        print("hiii2");
                        print(selectedPrice);
                        print("hiii2");
                        print(dateTime);
                        if (_n != 0 && selectedPrice != "" && dateTime != "") {
                          await postRequest();
                        } else {
                          if (dateTime == "")
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: textcolour2,
                                      )),
                                  title: Text("Select Date and Time"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(color: textcolour2),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        return 0;
                                      },
                                    )
                                  ],
                                ));
                          else if (selectedPrice == "")
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: textcolour2,
                                      )),
                                  title: Text(
                                      "Select ${serviceType.toString()} categories"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(color: textcolour2),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        return 0;
                                      },
                                    )
                                  ],
                                ));
                          else if (_n == 0) {
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: textcolour2,
                                      )),
                                  title: Text("No. of customer cannot be 0."),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(color: textcolour2),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        return 0;
                                      },
                                    )
                                  ],
                                ));
                          }
                        }
                      },
                      shape: StadiumBorder(),
                      color: Colors.white,
                      child: buttonLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "Send Service Request",
                              style:
                                  TextStyle(color: textcolour2, fontSize: 19),
                            ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Future<void> postRequest() async {
    setState(() {
      buttonLoading = true;
    });

    await Firestore.instance.collection("ServiceRequest").add({
      "sellerUid": sellerDetails.userUid,
      "sellerDocid": sellerDetails.userDocid,
      "sellerEmail": sellerDetails.userEmail,
      "sellerPic": sellerDetails.sellerPic,
      "sellerName": sellerDetails.firstname + " " + sellerDetails.lastname,
      "userUid": userDetails.userUid,
      "ServicePrice": selectedPrice,
      "NumberOfPerson": _n.toString(),
      "DateTime": dateTime,
      "rating": sellerDetails.rating,
      "numberOfReviews": sellerDetails.numberOfReviews,
      "userDocid": userDetails.userDocid,
      "userEmail": userDetails.userEmail,
      "userName": userDetails.firstname + " " + userDetails.lastname,
      "serviceType": serviceType,
      "accepted": false,
      "rated": false,
      "rejected": false,
      "completed": false,
    });

    await Firestore.instance
        .collection("Sellers")
        .doc(sellerDetails.userDocid)
        .update({"notificationOpened": false});

    setState(() {
      buttonLoading = false;
    });
    Navigator.pop(context);
  }
}
