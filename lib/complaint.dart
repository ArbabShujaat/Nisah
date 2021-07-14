import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:servicesapp/Models/models.dart';
import 'package:servicesapp/bookingdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  TextEditingController tittle = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    tittle.dispose();
    description.dispose();
    super.dispose();
  }

  bool _loading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: textcolor,
        title: Text("Complaint / Suggestion"),
      ),
      body: Container(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Please write to us for any queries",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: textcolor),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Theme(
                          data: new ThemeData(
                            primaryColor: textcolor,
                            primaryColorDark: textcolor,
                          ),
                          child: TextFormField(
                            controller: tittle,
                            maxLength: 40,
                            decoration: InputDecoration(hintText: "Title"),
                            validator: (String val) {
                              if (val.trim().isEmpty) {
                                return "Field must not be empty";
                              }

                              return null;
                            },
                          )),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Theme(
                          data: new ThemeData(
                            primaryColor: textcolor,
                            primaryColorDark: textcolor,
                          ),
                          child: TextFormField(
                            controller: description,
                            maxLines: 3,
                            maxLength: 150,
                            decoration: InputDecoration(
                                hintText: "Description",
                                hintStyle: TextStyle()),
                            validator: (String val) {
                              if (val.trim().isEmpty) {
                                return "Field must not be empty";
                              }

                              return null;
                            },
                          )),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            await Firestore.instance
                                .collection("ComplainAndSuggestionCustomer")
                                .add({
                              "Description": description.text,
                              "Name": userDetails.firstname +
                                  " " +
                                  userDetails.lastname,
                              "DateTime": DateTime.now().toString(),
                              "Email": userDetails.userEmail,
                              "Location": userDetails.address,
                              "Tittle": tittle.text
                            });
                            Navigator.pop(context);
                            setState(() {
                              _loading = false;
                            });
                          }
                        },
                        color: textcolor,
                        height: 60,
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
