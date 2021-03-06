import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:servicesapp/Editprofile..dart';
import 'package:servicesapp/Models/models.dart';
import 'package:servicesapp/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

final Color textcolorr = Color(0xFFFFFFFF);
final Color textcolorRR = Color(0XFF993052);

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textcolorr,
      appBar: AppBar(
        backgroundColor: textcolorRR,
        iconTheme: new IconThemeData(color: textcolorr),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 90.0,
              ),
              Container(
                alignment: Alignment.center,
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/female.png"),
                        fit: BoxFit.cover)),
              ),
            ],
          ),
          FlatButton.icon(
              splashColor: textcolorRR,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              icon: Icon(
                Icons.edit,
                color: textcolorRR,
              ),
              label: Text(
                "Edit Profile",
                style: TextStyle(color: textcolorRR),
              )),
          // Image.asset("assets/gentle.jpg",
          //     height: 350, width: MediaQuery.of(context).size.width),
          SizedBox(
            height: 20.0,
          ),

          Container(
            decoration: BoxDecoration(
                color: textcolorRR,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
            height: 400,
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          "Name:",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          userDetails.firstname + " " + userDetails.lastname,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 18),
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Mobile number:",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Icon(
                          Icons.call,
                          size: 40.0,
                          color: Colors.green,
                        ),
                        Text(
                          userDetails.number,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Email:",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        userDetails.userEmail,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.all(10.0),
                //       child: Text(
                //         "Location:",
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20),
                //       ),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.all(0.0),
                //       child: Text(
                //         userDetails.address,
                //         maxLines: 1,
                //         overflow: TextOverflow.ellipsis,
                //         softWrap: false,
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.w300,
                //             fontSize: 20),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Gender",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        userDetails.gender,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70.0,
                ),
                MaterialButton(
                  height: 50,
                  minWidth: 200,
                  shape: StadiumBorder(),
                  color: Colors.white,
                  onPressed: () async {
                    await signOut(context);
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(color: textcolorRR, fontSize: 20),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> signOut(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    } catch (e) {
      print(e); //
    }
  }
}
