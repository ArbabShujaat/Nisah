import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:servicesapp/Models/models.dart';

import 'package:servicesapp/bookingdetails.dart';
import 'package:servicesapp/help.dart';

import 'package:servicesapp/nearbysellers.dart';
import 'package:servicesapp/notifications.dart';
import 'package:servicesapp/userprofile.dart';

import 'Search.dart';

final Color textcolor = Color(0XFF993052);
String serviceType;

class SearchedHome extends StatefulWidget {
  @override
  _SearchedHomeState createState() => _SearchedHomeState();
}

class _SearchedHomeState extends State<SearchedHome> {
  int _index = 1;

  final controller = PageController(initialPage: 1, keepPage: true);

  void pageChanged(int index) {
    setState(() {
      _index = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      controller.animateToPage(index,
          duration: Duration(milliseconds: 50), curve: Curves.ease);
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      appBar: AppBar(
        backgroundColor: textcolor,
        leading: Icon(Icons.add_location_alt),
        // actions: [
        //   Padding(
        //       padding: EdgeInsets.all(5.0),
        //       child: Icon(Icons.shopping_cart_outlined)),
        // ],
        title: Text(
          userDetails.address,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomScrollView(
                shrinkWrap: true,
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(0.0),
                    sliver: SliverGrid.count(
                      crossAxisCount: 2,
                      children: <Widget>[
                        if (searchedUser == 'Makeup')
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.all(15.0),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Stack(
                              alignment: AlignmentDirectional(-0.3, -0.3),
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      serviceType = 'Makeup';
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NearbySellerScreen()));
                                  },
                                  child: ClipRRect(
                                    child: Image.asset(
                                      ("assets/one.jpg"),
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: double.maxFinite,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: textcolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0))),
                                  width: 300,
                                  margin: EdgeInsets.only(
                                    top: 144,
                                  ),
                                  child: Text(
                                    'Make up',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (searchedUser == 'Hair Dressing')
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.all(15.0),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Stack(
                              alignment: AlignmentDirectional(-0.3, -0.3),
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      serviceType = 'Hair Dressing';
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NearbySellerScreen()));
                                  },
                                  child: ClipRRect(
                                    child: Image.asset(
                                      ("assets/two.jpg"),
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: double.maxFinite,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: textcolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0))),
                                  width: 300,
                                  margin: EdgeInsets.only(
                                    top: 144,
                                  ),
                                  child: Text(
                                    'Hair Dressing',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (searchedUser == 'Massage services')
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.all(15.0),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Stack(
                              alignment: AlignmentDirectional(-0.3, -0.3),
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      serviceType = 'Massage services';
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NearbySellerScreen()));
                                  },
                                  child: ClipRRect(
                                    child: Image.asset(
                                      ("assets/three.jpg"),
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: double.maxFinite,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: textcolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0))),
                                  width: 300,
                                  margin: EdgeInsets.only(
                                    top: 144,
                                  ),
                                  child: Text(
                                    'Massage services',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (searchedUser == 'Heena')
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.all(15.0),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Stack(
                              alignment: AlignmentDirectional(-0.3, -0.3),
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      serviceType = 'Heena';
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NearbySellerScreen()));
                                  },
                                  child: ClipRRect(
                                    child: Image.asset(
                                      ("assets/four.jpg"),
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: double.maxFinite,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: textcolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0))),
                                  width: 300,
                                  margin: EdgeInsets.only(
                                    top: 144,
                                  ),
                                  child: Text(
                                    'Heena',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (searchedUser == 'Pedicure & Manicure')
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.all(15.0),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Stack(
                              alignment: AlignmentDirectional(-0.3, -0.3),
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      serviceType = 'Pedicure & Manicure';
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NearbySellerScreen()));
                                  },
                                  child: ClipRRect(
                                    child: Image.asset(
                                      ("assets/five.jpg"),
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: double.maxFinite,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: textcolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0))),
                                  margin: EdgeInsets.only(
                                    top: 144,
                                  ),
                                  child: Text(
                                    'Pedicure & Manicure',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (searchedUser == 'Photography')
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.all(15.0),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Stack(
                              alignment: AlignmentDirectional(-0.3, -0.3),
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      serviceType = 'Photography';
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NearbySellerScreen()));
                                  },
                                  child: ClipRRect(
                                    child: Image.asset(
                                      ("assets/six.jpg"),
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: double.maxFinite,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: textcolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0))),
                                  margin: EdgeInsets.only(
                                    top: 144,
                                  ),
                                  child: Text(
                                    'Photography',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (searchedUser == 'Videography')
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.all(15.0),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Stack(
                              alignment: AlignmentDirectional(-0.3, -0.3),
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      serviceType = 'Videography';
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NearbySellerScreen()));
                                  },
                                  child: ClipRRect(
                                    child: Image.asset(
                                      ("assets/eight.jpg"),
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: double.maxFinite,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: textcolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0))),
                                  width: 300,
                                  margin: EdgeInsets.only(
                                    top: 144,
                                  ),
                                  child: Text(
                                    'Videography',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (searchedUser == 'Taxi services')
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.all(15.0),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Stack(
                              alignment: AlignmentDirectional(-0.3, -0.3),
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      serviceType = 'Taxi services';
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NearbySellerScreen()));
                                  },
                                  child: ClipRRect(
                                    child: Image.asset(
                                      ("assets/seven.jpg"),
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: double.maxFinite,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: textcolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0))),
                                  width: 300,
                                  margin: EdgeInsets.only(
                                    top: 144,
                                  ),
                                  child: Text(
                                    'Taxi services',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: textcolor),
      child: BottomNavigationBar(
        selectedItemColor: Colors.white, unselectedItemColor: Colors.white,

//      backgroundColor: Theme.of(context).primaryColor,
//      fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,

        elevation: 0,
        iconSize: 30,
        unselectedLabelStyle: TextStyle(),

        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text('Home', style: TextStyle())),
          BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookingDetails()));
                },
                child: Icon(
                  Icons.insert_drive_file,
                ),
              ),
              title: Text('Booking', style: TextStyle())),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()));
                  },
                  child: Icon(Icons.notification_important)),
              title: Text('Notifications', style: TextStyle(fontSize: 12))),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserProfile()));
                  },
                  child: Icon(Icons.person)),
              title: Text('Account', style: TextStyle())),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HelpScreen()));
                  },
                  child: Icon(Icons.help)),
              title: Text('Help', style: TextStyle())),
        ],
      ),
    );
  }
}
