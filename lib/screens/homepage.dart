import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:attendance/APIHELPEr/basehelper.dart';
import 'package:attendance/model/rostermodel.dart';
import 'package:attendance/model/singleton.dart';
import 'package:attendance/screens/login.dart';
import 'package:attendance/screens/map.dart';
import 'package:attendance/screens/schedule.dart';
import 'package:attendance/screens/uploadImage.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/const.dart';
import 'package:attendance/utils/route.dart';
import 'package:attendance/utils/styles.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

// LocationData currentLocation;
// var location = new Location();

class _HomePage extends State<HomePage> {
  var width, height;
  ValueNotifier<RosterModel> _dataNotifier = ValueNotifier<RosterModel>(null);
  var placeName;
  var placeId;
  bool bottomSheet = false;
  var ids;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("statue: ${User.userData.userResult.status}");
  }
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      key: _scaffold,
      bottomSheet: bottomSheet == true
          ? bottomSheetView(ids)
          : Container(
              height: 0,
            ),
      appBar: AppBar(
        backgroundColor: mainColor,
        // automaticallyImplyLeading: false,
        // leading:
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "",
          style: headingStyle.copyWith(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * .13,
                height: height * .05,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("images/qkplogo.jpeg"),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                width: width*.62,
              ),
              GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  AppRoutes.makeFirst(context, LoginScreen());
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    Text(
                      "Logout",
                      style: headingStyle.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: width * .03,
          ),
        ],
      ),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(width * .02),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     // cardWidget("My Roster C(0)S(1)", "", "",1),
            //     GestureDetector(
            //       onTap: () {

            //       },
            //       child: Card(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(width * .04),
            //         ),
            //         child: Container(
            //           padding: EdgeInsets.all(width * .02),
            //           width: width * .9,
            //           height: height * .225,
            //           decoration: BoxDecoration(
            //               color: mainColor,
            //               borderRadius: BorderRadius.circular(width * .04)),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Icon(
            //                     Icons.location_pin,
            //                     size: height * .1,
            //                     color: Colors.white,
            //                   )
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: height * .02,
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Flexible(
            //                     child: Text(
            //                       placeName == null
            //                           ? "Get Location"
            //                           : "$placeName",
            //                       maxLines: 2,
            //                       textAlign: TextAlign.center,
            //                       style: headingStyle.copyWith(
            //                           fontSize: 18,
            //                           color: Colors.white,
            //                           fontWeight: FontWeight.normal),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: height * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cardWidget(
                    User.userData.userResult.status == 0
                        ? "Book On"
                        : "Book Off",
                    1,
                    User.userData.userResult.status == 0
                        ? "images/enter.png"
                        : "images/outside.png",
                    1),
              ],
            ),
            SizedBox(
              height: height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cardWidget("Upload Image", "", "images/image.png", 7),
                // Container(
                //   width: width*.45,
                // )
                cardWidget("My Shifts", "", "", 2)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cardWidget("Call Control Room", "", "", 3),
                // Container(
                //   width: width*.45,
                // )
                cardWidget("Report Incident", "", "", 4)
              ],
            ),
          ],
        ),
      ),
    );
  }

  alAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(15.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.height * .37,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .8,
                          height: MediaQuery.of(context).size.height * .3,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * .02)),
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * .02),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .04,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width * .7,
                                    height: height * .15,
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius:
                                            BorderRadius.circular(width * .03),
                                        // shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                AssetImage("images/image.jpeg"),
                                            fit: BoxFit.fill)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .013,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      AppRoutes.pop(context);
                                      // AppRoutes.push(context, LoginScreen());
                                    },
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .06,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .02),
                                            color: mainColor),
                                        child: Center(
                                          child: Text(
                                            "Send",
                                            textAlign: TextAlign.center,
                                            style: headingStyle.copyWith(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .13,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("images/logo.png"),
                                  fit: BoxFit.fill),
                              color: mainColor),
                        ),
                      ),
                    ],
                  )),
            ));

    //  showToast(
    //   '$message',
    //   context: context,
    //   animation: StyledToastAnimation.slideFromTop,
    //   backgroundColor: Colors.blue,
    //   dismissOtherToast: true,
    //   position: StyledToastPosition.top,
    // );
  }

  Widget bottomSheetView(id) {
    return Container(
      width: width,
      height: height * .22,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * .1),
            topRight: Radius.circular(width * .1),
          ),
          color: Colors.transparent,
          border: Border.all(color: Colors.grey[350])),
      padding: EdgeInsets.all(width * .02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    bottomSheet = false;
                  });
                },
                child: Icon(Icons.close, color: mainColor),
              ),
            ],
          ),
          FutureBuilder<RosterModel>(
              future: BaseHelper().getSchdule(context, _dataNotifier, 1),
              builder: (context, snapshot) {
                // print(snapshot.data)
                if (snapshot.hasData) {
                  return Container(
                    width: width * .7,
                    margin: EdgeInsets.only(
                      top: height * .02,
                    ),
                    height: height * .06,
                    decoration: BoxDecoration(
                      border: Border.all(color: lightGolden),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * .06),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .03,
                        right: MediaQuery.of(context).size.width * .02),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        iconEnabledColor: mainColor,
                        hint: Text("Select Place"),
                        items: snapshot.data.result.map((item) {
                          return new DropdownMenuItem(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("${item.userResult.siteName}"),
                              ],
                            ),
                            value: "${item.id}-${item.userResult.siteName}",
                          );
                        }).toList(),
                        onChanged: (value) {
                          print("$value");
                          setState(() {
                            placeId = value;
                            placeName = value.toString().split("-")[1];
                          });
                          print("place name: $placeName");
                        },
                        value: placeId == null ? null : "$placeId",
                        dropdownColor: Colors.white,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          SizedBox(
            height: height * .02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  print("id: $id");
                  if (placeName == null) {
                    showAlertDialog(context, "Please Select Place Name");
                  } else if (id == 7) {
                    AppRoutes.push(
                        context,
                        UploadImage(
                          lat: User.userData.lat,
                          long: User.userData.long,
                          place: placeName,
                        ));
                  } else if (id == 1) {
                    functionCalling();
                  }
                },
                child: Container(
                  width: width * .5,
                  height: height * .06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * .02),
                      color: mainColor),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: headingStyle.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _getUserLocation(id) async {
    EasyLoading.show();
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
      // EasyLoading.dismiss();
      print("lat: ${value.latitude}");
      print("long: ${value.longitude}");
      setState(() {
        User.userData.lat = value.latitude;
        User.userData.long = value.longitude;
      });
      final coordinates = new Coordinates(value.latitude, value.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var place;
      EasyLoading.dismiss();
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
        place = first.addressLine;
        placeName = place;
        print(place);
      });
      if (place != null) {
        // functionCalling(id);
      }
    }).catchError((onError) {
      EasyLoading.dismiss();
      print(onError);
    });

    // setState(() {
    //   currentPostion = LatLng(position.latitude, position.longitude);
    // });
  }

  functionCalling() {
    if (User.userData.userResult.status != 0) {
      BaseHelper()
          .checkinOut(User.userData.lat, User.userData.long,
              placeName == null ? "" : placeName, context)
          .then((value) {
        print(value);
        if (value['error'] == false) {
          setState(() {
            bottomSheet = false;
          });
          showAlertDialog(context, "${value['message']}");
          setState(() {
            if (value.toString().contains("Check out successfully")) {
              User.userData.userResult.status = 0;
            } else {
              User.userData.userResult.status = 1;
            }
          });
          // AppRoutes.makeFirst(context, HomePage());
        } else {
          showAlertDialog(context, "${value['message']}");
        }
      });
    } else if (placeName == null) {
      showAlertDialog(context, "Please select location first");
    } else {
      BaseHelper()
          .checkinOut(User.userData.lat, User.userData.long, placeName, context)
          .then((value) {
        print(value);
        if (value['error'] == false) {
          setState(() {
            bottomSheet = false;
          });
          showAlertDialog(context, "${value['message']}");
          setState(() {
            if (value.toString().contains("Check out successfully")) {
              User.userData.userResult.status = 0;
            } else {
              User.userData.userResult.status = 1;
            }
          });
          // AppRoutes.makeFirst(context, HomePage());
        } else {
          showAlertDialog(context, "${value['message']}");
        }
      });
    }
  }

  Widget cardWidget(text, icon, img, int id) {
    return GestureDetector(
      onTap: () async {
        if (id == 3 || id == 4) {
          var whatsapp = "+447311160578";
          var whatsappURl_android =
              "whatsapp://send?phone=" + whatsapp + "&text=hello";
          var whatappURL_ios =
              "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
          if (Platform.isIOS) {
            // for iOS phone only
            if (await canLaunch(whatappURL_ios)) {
              await launch(whatappURL_ios, forceSafariVC: false);
            } else {
              _scaffold.currentState.showSnackBar(
                  SnackBar(content: new Text("whatsapp no installed")));
            }
          } else {
            // android , web
            if (await canLaunch(whatsappURl_android)) {
              await launch(whatsappURl_android);
            } else {
              _scaffold.currentState.showSnackBar(
                  SnackBar(content: new Text("whatsapp no installed")));
            }
          }
        } else if (id == 1) {
          if (text == "Book Off") {
            functionCalling();
          } else {
            setState(() {
              bottomSheet = true;
              ids = 1;
            });
          }

          // if (placeName == null) {
          //   showAlertDialog(context, "Please Select Place");
          // } else {
          //   functionCalling();
          // }
        } else if (id == 7) {
          setState(() {
            bottomSheet = true;
            ids = 7;
          });
        } else if (id == 2) {
          AppRoutes.push(context, ScheduleScreen());
        }
        // _getUserLocation(id);
        // AppRoutes.push(
        //     context,
        //     Area_Needed(
        //       screen: id == 7 ? 1 : 0,
        //     ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * .04),
        ),
        child: Container(
          padding: EdgeInsets.all(width * .02),
          width: id == 1 ? width * .9 : width * .45,
          height: height * .225,
          decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(width * .04)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              img == ""
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("$img",
                            width: width * .25,
                            color: Colors.white,
                            height: height * .12,
                            fit: BoxFit.fill),
                      ],
                    ),
              SizedBox(
                height: height * .02,
              ),
              text == ""
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "$text",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: headingStyle.copyWith(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
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
}
