import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:servicesapp/Home.dart';
import 'package:servicesapp/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoder/geocoder.dart' as a;
import 'ForgotPassword.dart';
import 'Models/models.dart';

final Color textcolor = Color(0XFF993052);

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _loading = false;
  dynamic coordinates;
  dynamic first;
  dynamic addresses;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email = "  ";
  String password = "  ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Image.asset(
                    "assets/logooo.png",
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    "WELCOME",
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(30.0),
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
                              controller: emailController,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: "Enter Your Email",
                                hintStyle: TextStyle(
                                  color: textcolor,
                                ),
                                fillColor: textcolor,
                                // border: new OutlineInputBorder(
                                //   borderRadius: new BorderRadius.circular(25.0),
                                //   borderSide: new BorderSide(),
                                // ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Email cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: new TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                              ),
                            )),
                      )),
                  Padding(
                      padding: EdgeInsets.all(30.0),
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
                              obscureText: _obscureText,
                              controller: passwordController,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                    onTap: _toggle,
                                    child: new Icon(_obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                hintText: "Enter Your Password",
                                hintStyle: TextStyle(color: textcolor),
                                fillColor: textcolor,
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Password cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: new TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                              ),
                            )),
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Align(
                          child: Text(
                            "ForgotPassword?",
                            style: TextStyle(
                              color: Color(0xFF0e737b),
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          alignment: Alignment.bottomRight,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 60.0,
                      child: RaisedButton(
                        onPressed: () async {
                          print("hiii0");
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            try {
                              final User user = (await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              ))
                                  .user;
                              if (user != null) {
                                var prefs =
                                    await SharedPreferences.getInstance();
                                final userData = json.encode(
                                  {
                                    'userEmail': user.email,
                                    'userUid': user.uid,
                                  },
                                );
                                prefs.setString('userData', userData);
                                print("hiii1");
                                await Firestore.instance
                                    .collection("Users")
                                    .where("email",
                                        isEqualTo: emailController.text)
                                    .getDocuments()
                                    .then((value) async => {
                                          print("hiii2"),
                                          coordinates = new a.Coordinates(
                                              value.documents[0]["Latitude"],
                                              -value.documents[0]["Longitude"]),
                                          print("hiii3"),
                                          addresses = await a.Geocoder.local
                                              .findAddressesFromCoordinates(
                                                  coordinates),
                                          first = addresses.first,
                                          print(
                                              "${first.featureName} : ${first.addressLine}"),
                                          userDetails = UserDetails(
                                            address: first.addressLine,
                                            userEmail: value.documents[0]
                                                ["email"],
                                            userDocid:
                                                value.documents[0].documentID,
                                            userUid: value.documents[0]
                                                ["userUid"],
                                            latitude: value.documents[0]
                                                    ["Latitude"]
                                                .toString(),
                                            longitude: value.documents[0]
                                                    ["Longitude"]
                                                .toString(),
                                            notificationOpened:
                                                value.documents[0]
                                                    ["notificationOpened"],
                                            firstname: value.documents[0]
                                                ["firstName"],
                                            lastname: value.documents[0]
                                                ["lastName"],
                                            gender: value.documents[0]
                                                ["gender"],
                                            number: value.documents[0]
                                                ["phoneNumber"],
                                            taxiActive: value.documents[0]
                                                ["taxiActive"],
                                          )
                                        });
                                setState(() {
                                  _loading = false;
                                });

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              }
                            } catch (signUpError) {
                              setState(() {
                                _loading = false;
                              });
                              showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(18.0),
                                        side: BorderSide(
                                          color: Colors.red,
                                        )),
                                    title: Text(signUpError.message),
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
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 60.0),
                            alignment: Alignment.center,
                            child: _loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    "Sign In",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      height: 60.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
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
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 60.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Sign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )));
  }
}
