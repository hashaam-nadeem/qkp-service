import 'dart:async';
import 'package:attendance/model/singleton.dart';
import 'package:geocoder/geocoder.dart';
import 'package:attendance/APIHELPEr/basehelper.dart';
import 'package:attendance/screens/homepage.dart';
import 'package:attendance/screens/uploadImage.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/const.dart';
import 'package:attendance/utils/route.dart';
import 'package:attendance/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as prefix;
// import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_google_places/flutter_google_places.dart';

// LocationData currentLocation;
// var location = new Location();

class Area_Needed extends StatefulWidget {
  var screen = 0;
  Area_Needed({@required this.screen});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Area_Needed();
  }
}

class _Area_Needed extends State<Area_Needed> {
  double slidervalue = 100;
  var locationLat, locationLong;
  // MyBloc _bloc = MyBloc();
  BitmapDescriptor pinLocationIcon;
  Set<Marker> marker = new Set();
  static const kGoogleApiKey = "AIzaSyDruBo_2bXpTSTl7cb71GCqHueSV2jX30g";
  prefix.GoogleMapsPlaces _places =
      prefix.GoogleMapsPlaces(apiKey: kGoogleApiKey);
  LatLng _center = LatLng(31.5204, 74.3587);
  Completer<GoogleMapController> _controller = Completer();
  // CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(currentLocation.longitude, currentLocation.longitude),
  //   zoom: 14.4746,
  // );
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.5204, 74.3587),
    zoom: 14.4746,
  );

  CameraPosition _kLake = CameraPosition(
      target: LatLng(25.2854, 51.5310), zoom: 19.151926040649414);

  Future<void> gotoLocaiton() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  searchLocation() async {
    const kGoogleApiKey = "AIzaSyDruBo_2bXpTSTl7cb71GCqHueSV2jX30g";

    await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: Mode.overlay, // Mode.fullscreen
      language: "en",
    ).then((value) async {
      if (value != null) {
        print(value.placeId);
        displayPrediction(value);
      }
    });
  }

  displayPrediction(prefix.Prediction p) async {
    print("place id........ : ${p.placeId}");
    BaseHelper().getPlaceDetailFromId(p.placeId).then((value) {
      LatLng loc = value;
      print("lat long: ${loc.latitude}:  ${loc.longitude}");
      setState(() {
        _kLake = CameraPosition(
            target: LatLng(loc.latitude, loc.longitude), zoom: 15);
      });
      gotoLocaiton();
    });
    final detail = await _places.getDetailsByPlaceId(p.placeId).then((val) {
      print(val.result.geometry.location.lat);
    });
    double lat = detail.result.geometry.location.lat;
    double lng = detail.result.geometry.location.lng;
    print("place id lat:$lat, long: $lng");
  }

  getUserLocation() async {
    try {
//       await location.getLocation().then((onValue) async {
//         print(onValue.latitude);
//         if (onValue != null) {
//           setState(() {
//             _kLake = CameraPosition(
//                 target: LatLng(onValue.latitude, onValue.longitude), zoom: 14);
//           });
//           gotoLocaiton();
//         } else {}
//         setState(() {
//           // User.userData.lat = onValue.latitude;
//           // User.userData.long = onValue.longitude;
//         });
//         // print(User.userData.lat);
//         // print(User.userData.long);
// //        getAddress(User.userData.lat, User.userData.lat);
//       }).catchError((onError) async {
//         print(onError.toString());
//         if (onError.toString().contains("PERMISSION_DENIED_NEVER_ASK")) {
//           // bool isOpened = await PermissionHandler().openAppSettings();
//         } else {
//           // getUserLocation();
//         }
//       });
    } on Exception catch (e) {
      print("call");
      //  getUserLocation();
      // currentLocation = null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setCustomMapPin();
    getUserLocation();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(20, 20)),
        'images/pinmarker.png');
  }

  var width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
        body: Container(
      child: Stack(
        children: <Widget>[
          _googlemaps(context),
          Align(
            alignment: Alignment.topCenter,
            child: appbarWidget(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * .12,
                ),
                GestureDetector(
                  onTap: () async {
                    final coordinates =
                        new Coordinates(_center.latitude, _center.longitude);
                    var addresses = await Geocoder.local
                        .findAddressesFromCoordinates(coordinates);
                    var place;
                    setState(() {
                      var first = addresses.first;
                      // print("${addresses.first.locality}");
                      // // first = first.addressLine;
                      // // User.userData.address =
                      // //     addresses.first.addressLine;
                      // User.userData.homeLat = _center.latitude;
                      // User.userData.homeLong = _center.longitude;
                      // User.userData.lat = _center.latitude;
                      // User.userData.long = _center.longitude;
                      // address.text = first.addressLine.toString();
                      place = first.locality;
                    });
                    if (widget.screen == 0) {
                      BaseHelper()
                          .checkinOut(_center.latitude, _center.longitude,
                              place, context)
                          .then((value) {
                        print(value);
                        if (value['error'] == false) {
                          showAlertDialog(context, "${value['message']}");
                          setState(() {
                            User.userData.userResult.status = 1;
                          });
                          AppRoutes.makeFirst(context, HomePage());
                        } else {
                          showAlertDialog(context, "${value['message']}");
                        }
                      });
                      // AppRoutes.makeFirst(context, HomePage());
                    } else {
                      AppRoutes.push(
                          context,
                          UploadImage(
                            lat: _center.latitude,
                            long: _center.longitude,
                            place: place,
                          ));
                    }
                  },
                  child: Container(
                    width: width * .5,
                    margin: EdgeInsets.only(top: height * .02),
                    height: MediaQuery.of(context).size.height * .06,
                    decoration: BoxDecoration(
                        color: lightmainColor,
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * .03))),
                    child: Center(
                      child: Text(
                        "Selected",
                        style: headingStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        getUserLocation();
                      },
                      child: Icon(Icons.my_location,
                          size: 40, color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _googlemaps(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            mapType: MapType.normal,

            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .25),
            markers: marker,
            onCameraMove: (move) {
              setState(() {
                _center = move.target;
                circles.clear();
                marker.clear();
                // marker.add(
                //   Marker(
                //     markerId: MarkerId("selected-location"),
                //     position: _center,
                //   ),
                // );
                // circles
                //   ..add(Circle(
                //       circleId: CircleId("abcd"),
                //       radius: slidervalue,
                //       strokeColor: Colors.green,
                //       center: move.target));
              });
            },
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            //circles: circles,
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .22),
                child: Image.asset(
                  "images/pinmarker.png",
                  width: MediaQuery.of(context).size.width * .15,
                  height: MediaQuery.of(context).size.height * .2,
                )))
      ],
    );
  }

  Set<Circle> circles = Set.from([
    Circle(
      circleId: CircleId("map"),
      strokeColor: mainColor,
      center: LatLng(31.5102, 74.3441),
      radius: 10000,
    )
  ]);

  Widget appbarWidget() {
    return
        // Main Grounded Container
        Container(
      height: MediaQuery.of(context).size.height * .12,
      child: Stack(
        children: <Widget>[
          // Green Container
          Container(
            height: MediaQuery.of(context).size.height * .2,
            color: mainColor,
          ),

          // data Containe
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Text(''),
                // Text(''),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * .27,
                      // ),
                      Text(
                        "Location",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          searchLocation();
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
