import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:servicesapp/Models/models.dart';

import 'package:servicesapp/bookingdetails.dart';
import 'package:servicesapp/help.dart';

import 'package:servicesapp/nearbysellers.dart';
import 'package:servicesapp/notifications.dart';
import 'package:servicesapp/userprofile.dart';

import 'Search.dart';
import 'maps.dart';

final Color textcolor = Color(0XFF993052);
String serviceType;

String one;
String two;
String three;
String four;
String five;
String six;
String seven;
String eight;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 1;
  bool _loading = true;
  LocationData _locationData;
  Location location = new Location();

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
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    await Firestore.instance
        .collection("About Us")
        .getDocuments()
        .then((value) async => {
              aboutUs = value.documents[0]["aboutUs"],
            });

    await Firestore.instance
        .collection("Contact Us")
        .getDocuments()
        .then((value) async => {
              contactUs = value.documents[0]["PhoneNumber"],
            });

    _locationData = await location.getLocation();

    String docid = "";

    setState(() {
      _loading = false;
    });
    super.didChangeDependencies();
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          showSearch(context: context, delegate: DataSearch());
                        },
                        onLongPress: () {
                          showSearch(context: context, delegate: DataSearch());
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: textcolor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: new Theme(
                              data: new ThemeData(
                                primaryColor: Colors.redAccent,
                                primaryColorDark: Colors.redAccent,
                              ),
                              child: ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Search for your services",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),

                                // style: TextStyle(color: Colors.white),
                                // readOnly: true,
                                // decoration: new InputDecoration(
                                //   prefixIcon: Icon(
                                //     Icons.search,
                                //     color: Colors.white,
                                //   ),
                                //   hintText: "Search for your services",
                                //   hintStyle: TextStyle(
                                //     color: Colors.white,
                                //   ),
                                //   fillColor: Colors.white,
                                //   border: new OutlineInputBorder(
                                //       borderSide: new BorderSide(),
                                //       borderRadius: BorderRadius.circular(25.0)),
                                //   //fillColor: Colors.white
                                // ),
                              )),
                        ),
                      ),
                      CustomScrollView(
                        shrinkWrap: true,
                        primary: false,
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.all(0.0),
                            sliver: SliverGrid.count(
                              crossAxisCount: 2,
                              children: <Widget>[
                                Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.all(15.0),
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: textcolor.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0))),
                                        width: 300,
                                        margin: EdgeInsets.only(
                                          top: 44,
                                        ),
                                        child: Text(
                                          'Make Up',
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
                                Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.all(15.0),
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: textcolor.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0))),
                                        width: 300,
                                        margin: EdgeInsets.only(
                                          top: 44,
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
                                Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.all(15.0),
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Stack(
                                    alignment: AlignmentDirectional(-0.3, -0.3),
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            serviceType = 'Massage ervices';
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: textcolor.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0))),
                                        width: 300,
                                        margin: EdgeInsets.only(
                                          top: 44,
                                        ),
                                        child: Text(
                                          'Massage Services',
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
                                Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.all(15.0),
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: textcolor.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0))),
                                        width: 300,
                                        margin: EdgeInsets.only(
                                          top: 44,
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
                                Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.all(15.0),
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      ),
                                      Container(
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: textcolor.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0))),
                                        margin: EdgeInsets.only(
                                          top: 44,
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
                                Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.all(15.0),
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      ),
                                      Container(
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: textcolor.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0))),
                                        margin: EdgeInsets.only(
                                          top: 44,
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
                                Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.all(15.0),
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: textcolor.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0))),
                                        width: 300,
                                        margin: EdgeInsets.only(
                                          top: 44,
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
                                Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.all(15.0),
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Stack(
                                    alignment: AlignmentDirectional(-0.3, -0.3),
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            serviceType = 'Taxi Services';
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: textcolor.withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0))),
                                        width: 300,
                                        margin: EdgeInsets.only(
                                          top: 44,
                                        ),
                                        child: Text(
                                          'Taxi Services',
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
                onTap: () async {
                  Firestore.instance
                      .collection("Users")
                      .document(userDetails.userDocid)
                      .update({"notificationOpened": true});

                  setState(() {
                    userDetails.notificationOpened = true;
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Notifications()));
                },
                child: userDetails.notificationOpened
                    ? Icon(Icons.notification_important)
                    : new Stack(
                        children: <Widget>[
                          new Icon(Icons.notifications),
                          new Positioned(
                            right: 0,
                            child: new Container(
                              padding: EdgeInsets.all(1),
                              decoration: new BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: new Text(
                                '1',
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
              ),
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
