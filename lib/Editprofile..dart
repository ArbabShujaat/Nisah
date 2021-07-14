import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:servicesapp/Home.dart';
import 'package:servicesapp/Models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Color textcolor = Color(0XFF993052);

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool monVal = true;
  bool tuVal = true;
  bool _loading = false;

  final TextEditingController _controller = new TextEditingController();
  var items = [
    'Dubai',
    'India',
    'Australia',
    'Pakistan',
  ];
  final _formKey = GlobalKey<FormState>();
  int selectedRadio;
  bool fNameChange = false;
  bool lNameChange = false;
  bool numberChange = false;

  TextEditingController firstname =
      TextEditingController(text: userDetails.firstname);
  TextEditingController lastname =
      TextEditingController(text: userDetails.lastname);
  TextEditingController phoneNumber =
      TextEditingController(text: userDetails.number);
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Edit Profile"),
          backgroundColor: textcolor,
          elevation: 0.0,
        ),
        body: Container(
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: new Theme(
                                  data: new ThemeData(
                                    primaryColor: textcolor,
                                    primaryColorDark: textcolor,
                                  ),
                                  child: TextFormField(
                                    controller: firstname,
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        size: 30,
                                        color: textcolor,
                                      ),
                                      hintText: userDetails.firstname,
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: textcolor,
                                      ),
                                      fillColor: textcolor,
                                    ),
                                    onChanged: (a) {
                                      fNameChange = true;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                    ),
                                  )),
                            )),
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: new Theme(
                                  data: new ThemeData(
                                    primaryColor: textcolor,
                                    primaryColorDark: textcolor,
                                  ),
                                  child: TextFormField(
                                    controller: lastname,
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        size: 30,
                                        color: textcolor,
                                      ),
                                      hintText: userDetails.lastname,
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: textcolor,
                                      ),
                                      fillColor: textcolor,
                                    ),
                                    onChanged: (a) {
                                      lNameChange = true;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                    ),
                                  )),
                            )),
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: new Theme(
                                  data: new ThemeData(
                                    primaryColor: textcolor,
                                    primaryColorDark: textcolor,
                                  ),
                                  child: TextFormField(
                                    controller: phoneNumber,
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.call,
                                        size: 30,
                                        color: textcolor,
                                      ),
                                      hintText: userDetails.number,
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: textcolor,
                                      ),
                                      fillColor: textcolor,
                                    ),
                                    onChanged: (a) {
                                      numberChange = true;
                                    },
                                    keyboardType: TextInputType.phone,
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                    ),
                                  )),
                            )),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text(
                                "Gender",
                                style: TextStyle(
                                    color: textcolor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[],
                              ),
                              // [Tuesday] checkbox
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Female",
                                    style: TextStyle(
                                        color: textcolor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Radio(
                                    activeColor: textcolor,
                                    value: 1,
                                    groupValue: 1,
                                    onChanged: (val) {
                                      print("Radio $val");
                                      setSelectedRadio(val);
                                    },
                                  ),
                                ],
                              ),
                              // [Wednesday] checkbox
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Divider(
                              thickness: 2,
                              color: textcolor,
                            )),
                        Container(
                            height: 50.0,
                            child: RaisedButton(
                              onPressed: () async {
                                setState(() {
                                  _loading = true;
                                });
                                if (fNameChange) {
                                  await Firestore.instance
                                      .collection("Users")
                                      .document(userDetails.userDocid)
                                      .update({"firstName": firstname.text});
                                  userDetails.firstname = firstname.text;
                                }
                                if (lNameChange) {
                                  await Firestore.instance
                                      .collection("Users")
                                      .document(userDetails.userDocid)
                                      .update({"lastName": lastname.text});

                                  userDetails.lastname = lastname.text;
                                }
                                if (numberChange) {
                                  await Firestore.instance
                                      .collection("Users")
                                      .document(userDetails.userDocid)
                                      .update(
                                          {"phoneNumber": phoneNumber.text});
                                  userDetails.number = phoneNumber.text;
                                }
                                setState(() {
                                  _loading = false;
                                });

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => HomeScreen()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFDD4B7C),
                                        Color(0xFF0e737b)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 300.0, minHeight: 60.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Update",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ])),
                ),
        ));
  }
}
