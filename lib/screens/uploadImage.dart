import 'dart:io';

import 'package:attendance/APIHELPEr/basehelper.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/custombutton.dart';
import 'package:attendance/utils/customtextfield.dart';
import 'package:attendance/utils/route.dart';
import 'package:attendance/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'forgotpassword.dart';

class UploadImage extends StatefulWidget {
  var lat, long, place;
  UploadImage({@required this.lat, @required this.long, @required this.place});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _languageScreen();
  }
}

class _languageScreen extends State<UploadImage> {
  var width, height;
  var otp;
  bool isNumber = false;
  File image;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          "Uplaod Image",
          style: headingStyle.copyWith(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            AppRoutes.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image == null
                      ? Container(
                          height: 2,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width * .9,
                              height: height * .35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(width * .03)),
                                  image: DecorationImage(
                                      image: FileImage(image),
                                      fit: BoxFit.fill)),
                            )
                          ],
                        ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          BaseHelper().chooseImage(false).then((value) {
                            setState(() {
                              image = value;
                            });
                            print(value.path);
                          });
                          //  AppRoutes.push(context, HomePage());
                        },
                        child: CustomButton(
                          width: width * .4,
                          height: height * .06,
                          color: lightmainColor,
                          title: "Upload image",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  image == null
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                BaseHelper().uploadImage(image, widget.lat,
                                    widget.long, widget.place, context);
                                //  AppRoutes.push(context, HomePage());
                              },
                              child: CustomButton(
                                width: width * .4,
                                height: height * .06,
                                color: lightmainColor,
                                title: "Submit",
                              ),
                            ),
                          ],
                        ),
                ],
              )
            : Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: new ColorFilter.mode(
                                              Colors.black.withOpacity(0.3),
                                              BlendMode.darken),
                              image: FileImage(image), fit: BoxFit.fill),
                              
                              ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: width * .03, bottom: height * .03),
                              child: Text(
                                "${widget.place}",
                                style: headingStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: width * .03, bottom: height * .03),
                              child: Text(
                                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                style: headingStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  BaseHelper().uploadImage(image, widget.lat,
                                      widget.long, widget.place, context);
                                  //  AppRoutes.push(context, HomePage());
                                },
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            .03),
                                  ),
                                  child: Container(
                                    width: width * .25,
                                    height: height * .06,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width *
                                                .03),
                                        color: Colors.white,
                                        border: Border.all(color: mainColor)),
                                    child: Center(
                                      child: Text(
                                        "Submit",
                                        style: headingStyle.copyWith(
                                            color: lightmainColor,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
