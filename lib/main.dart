import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:servicesapp/PushNotification/FirebasePushNotificatiom.dart';
import 'package:servicesapp/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:http/http.dart' as http;

import 'Models/models.dart';
import 'package:geocoder/geocoder.dart' as name;

import 'Home.dart';
import 'PushNotification/TokemModel.dart';

String taxisellerDocid;
FirebasePushNotificationService pushNotificationService =
    FirebasePushNotificationService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

final Color background = Color(0xFFFDDBED);
final FirebaseMessaging _fcm = FirebaseMessaging();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    pushNotificationService.initialize();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nisah App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  dynamic first;
  dynamic coordinates;
  LocationData _locationData;
  dynamic addresses;
  void initState() {
    super.initState();

    Timer(Duration(seconds: 0), () async {
      var prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey("userData")) {
        final extractedUserData =
            json.decode(prefs.getString('userData')) as Map<String, Object>;
        Location location = new Location();

        bool _serviceEnabled;
        PermissionStatus _permissionGranted;

        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            showDialog(
                context: context,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.red[400],
                      )),
                  title: Text(
                      "Turn on the location and grant location permission."),
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
                        color: Colors.red[400],
                      )),
                  title: Text(
                      "Turn on the location and grant location permission."),
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

        _locationData = await location.getLocation();

        String _host = 'https://maps.google.com/maps/api/geocode/json';

        await Firestore.instance
            .collection("Users")
            .where("email", isEqualTo: extractedUserData['userEmail'])
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
                    userDocid: value.documents[0].documentID,
                    userUid: value.documents[0]["userUid"],
                    latitude: value.documents[0]["Latitude"].toString(),
                    longitude: value.documents[0]["Longitude"].toString(),
                    firstname: value.documents[0]["firstName"],
                    lastname: value.documents[0]["lastName"],
                    notificationOpened: value.documents[0]
                        ["notificationOpened"],
                    gender: value.documents[0]["gender"],
                    taxiActive: value.documents[0]["taxiActive"],
                    number: value.documents[0]["phoneNumber"],
                  )
                });
        String fcmToken = await _fcm.getToken();
        final tokenRef = FirebaseFirestore.instance
            .collection("Users")
            .doc(userDetails.userDocid)
            .collection('tokens')
            .doc(fcmToken);
        await tokenRef.set(
          TokenModel(token: fcmToken, createdAt: FieldValue.serverTimestamp())
              .toJson(),
        );

        await Firestore.instance
            .collection("Users")
            .document(userDetails.userDocid)
            .update({
          "Latitude": _locationData.latitude,
          "Longitude": _locationData.longitude
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Image(
          width: 350,
          image: AssetImage(
            "assets/logooo.png",
          ),
        )));
  }
}
