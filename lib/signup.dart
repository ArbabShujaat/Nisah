import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:servicesapp/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import 'Models/models.dart';
import 'package:geocoder/geocoder.dart' as name;

final Color textcolor = Color(0XFF993052);

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool monVal = true;
  bool tuVal = true;
  bool buttonLoading = false;
  LocationData _locationData;
  GeoFirePoint point;
  dynamic first;
  dynamic coordinates;
  dynamic addresses;

  final TextEditingController signupFirstNamecontroller =
      new TextEditingController();
  final TextEditingController signupLastNamecontroller =
      new TextEditingController();
  final TextEditingController signupNumbercontroller =
      new TextEditingController();
  final TextEditingController signupEmailcontroller =
      new TextEditingController();
  final TextEditingController signupPasswordcontroller =
      new TextEditingController();
  final TextEditingController signupConfirmPassworddDescriptioncontroller =
      new TextEditingController();

  final TextEditingController _controller = new TextEditingController();
  var items = [
    'Dubai',
    'India',
    'Australia',
    'Pakistan',
  ];
  final _formKey = GlobalKey<FormState>();
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  @override
  void dispose() {
    signupFirstNamecontroller.dispose();
    signupConfirmPassworddDescriptioncontroller.dispose();
    signupEmailcontroller.dispose();
    signupLastNamecontroller.dispose();
    signupNumbercontroller.dispose();
    signupPasswordcontroller.dispose();
    super.dispose();
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
          title: Text("Sign Up"),
          backgroundColor: textcolor,
          elevation: 0.0,
        ),
        body: Form(
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
                            controller: signupFirstNamecontroller,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                size: 30,
                                color: textcolor,
                              ),
                              hintText: "Enter Your first name",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: textcolor,
                              ),
                              fillColor: textcolor,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                            validator: (String val) {
                              if (val.trim().isEmpty) {
                                return "Field must not be empty";
                              }
                              return null;
                            },
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
                            controller: signupLastNamecontroller,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                size: 30,
                                color: textcolor,
                              ),
                              hintText: "Enter Your last name",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: textcolor,
                              ),
                              fillColor: textcolor,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                            validator: (String val) {
                              if (val.trim().isEmpty) {
                                return "Field must not be empty";
                              }
                              return null;
                            },
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
                            controller: signupNumbercontroller,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.call,
                                size: 30,
                                color: textcolor,
                              ),
                              hintText: "+9x xxxx xxxx",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: textcolor,
                              ),
                              fillColor: textcolor,
                            ),
                            keyboardType: TextInputType.phone,
                            style: new TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                            validator: (String val) {
                              if (val.trim().isEmpty) {
                                return "Field must not be empty";
                              }
                              return null;
                            },
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
                            controller: signupEmailcontroller,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                size: 30,
                                color: textcolor,
                              ),
                              hintText: "Enter your email",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: textcolor,
                              ),
                              fillColor: textcolor,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                            validator: (String val) {
                              if (val.trim().isEmpty) {
                                return "Field must not be empty";
                              }
                              return null;
                            },
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
                            controller: signupPasswordcontroller,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 30,
                                color: textcolor,
                              ),
                              hintText: "Enter your password",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: textcolor,
                              ),
                              fillColor: textcolor,
                            ),
                            keyboardType: TextInputType.multiline,
                            style: new TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                            validator: (String val) {
                              if (val.trim().isEmpty) {
                                return "Field must not be empty";
                              }
                              return null;
                            },
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
                            controller:
                                signupConfirmPassworddDescriptioncontroller,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 30,
                                color: textcolor,
                              ),
                              hintText: "Re-enter your password",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: textcolor,
                              ),
                              fillColor: textcolor,
                            ),
                            keyboardType: TextInputType.multiline,
                            style: new TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                            validator: (String val) {
                              if (val.trim().isEmpty) {
                                return "Password must not be empty";
                              }
                              if (val.trim() != signupPasswordcontroller.text) {
                                return "Password doesnot match";
                              }
                              return null;
                            },
                          )),
                    )),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: new Theme(
                          data: new ThemeData(
                            primaryColor: textcolor,
                            primaryColorDark: textcolor,
                          ),
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Your current location will be used.",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                Icons.add_location,
                                size: 30,
                                color: textcolor,
                              ),
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
                                color: textcolor, fontWeight: FontWeight.bold),
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
                          buttonLoading = true;
                        });
                        if (_formKey.currentState.validate()) {
                          await signUp(context);
                        }
                        setState(() {
                          buttonLoading = false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFDD4B7C), Color(0xFF0e737b)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 300.0, minHeight: 60.0),
                          alignment: Alignment.center,
                          child: buttonLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  "SAVE",
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
        ));
  }

  Future<void> signUp(BuildContext context) async {
    try {
      User signupUser =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signupEmailcontroller.text,
        password: signupPasswordcontroller.text,
      ))
              .user;

      if (signupUser != null) {
        Location location = new Location();

        bool _serviceEnabled;
        PermissionStatus _permissionGranted;

        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            return;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            showDialog(
                context: context,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.red,
                      )),
                  title: Text("Kindly grant location permission"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ));
          }
        }

        _locationData = await location.getLocation();

        Geoflutterfire geo = Geoflutterfire();
        point = geo.point(
            latitude: _locationData.latitude,
            longitude: _locationData.longitude);

        print("hiiiiiii");

        print(_locationData.latitude);
        print(_locationData.longitude);
        await Firestore.instance.collection("Users").add({
          "email": signupEmailcontroller.text,
          "userUid": signupUser.uid,
          "firstName": signupFirstNamecontroller.text,
          "lastName": signupLastNamecontroller.text,
          "phoneNumber": signupNumbercontroller.text,
          "Longitude": _locationData.longitude,
          "Latitude": _locationData.latitude,
          "gender": "Female",
          "notificationOpened": true,
          'taxiActive': false
        });
        print("hiiiiiii2");
        print(signupEmailcontroller.text);
        print(signupUser.uid);
        await Firestore.instance
            .collection("Users")
            .where("email", isEqualTo: signupEmailcontroller.text)
            .getDocuments()
            .then((value) async => {
                  coordinates = new name.Coordinates(
                      value.documents[0]["Latitude"],
                      value.documents[0]["Longitude"]),
                  addresses = await name.Geocoder.local
                      .findAddressesFromCoordinates(coordinates),
                  first = addresses.first,
                  print("${first.featureName} : ${first.addressLine}"),
                  userDetails = UserDetails(
                    address: first.countryName,
                    userEmail: value.documents[0]["email"],
                    taxiActive: value.documents[0]["taxiActive"],
                    userDocid: value.documents[0].documentID,
                    notificationOpened: value.documents[0]
                        ["notificationOpened"],
                    userUid: value.documents[0]["userUid"],
                    latitude: value.documents[0]["Latitude"].toString(),
                    longitude: value.documents[0]["Longitude"].toString(),
                    firstname: value.documents[0]["firstName"],
                    lastname: value.documents[0]["lastName"],
                    gender: value.documents[0]["gender"],
                    number: value.documents[0]["phoneNumber"],
                  )
                });
        print("hiiiiiii3");
        var prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'userEmail': signupUser.email,
            'userUid': signupUser.uid,
          },
        );
        prefs.setString('userData', userData);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
      return 0;
    } catch (signUpError) {
      print("Hiiiii1");
      showDialog(
          context: context,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Colors.red[400],
                )),
            title: Text(signUpError.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.red[400]),
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
}
