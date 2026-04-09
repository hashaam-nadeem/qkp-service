import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/custombutton.dart';
import 'package:attendance/utils/customtextfield.dart';
import 'package:attendance/utils/route.dart';
import 'package:attendance/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'forgotpassword.dart';
import 'otp.dart';

class SendOtp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _languageScreen();
  }
}

class _languageScreen extends State<SendOtp> {
  var width, height;
  bool isNumber = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width*.5,height: height*.18,
                    decoration: BoxDecoration(
                      color: mainColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("images/logo.png"),fit: BoxFit.fill
                      )
                    ),
                  ),
                 
                ],
              ),
              SizedBox(
                height: height * .06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * .85,
                    height: height * .6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * .03),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                              spreadRadius: 0.5)
                        ],
                        color: mainColor.withOpacity(0.4)),
                    padding: EdgeInsets.all(width * .03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              controller: email,
                              pass: false,
                              width: width * .7,
                              number: true,
                              keyboardTypenumeric: false,
                              title: "Email",
                              height: height * 08,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                       
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: ()
                              {
                                AppRoutes.push(context, VerifyOtp());
                              },
                              child: CustomButton(
                                width: width * .5,
                                height: height * .06,
                                color: mainColor,
                                title:  "Send Otp",
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                        
                       
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
