import 'package:attendance/screens/login.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/custombutton.dart';
import 'package:attendance/utils/customtextfield.dart';
import 'package:attendance/utils/route.dart';
import 'package:attendance/utils/styles.dart';
import 'package:flutter/material.dart';
// import 'package:location/location.dart';


class SetPassword extends StatefulWidget
{
  var email,otp;
  SetPassword({@required this.email,@required this.otp});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _password();
  }
  
}

class _password extends State<SetPassword>{
  var width,height;
  TextEditingController pass=TextEditingController();
    TextEditingController confirmPass=TextEditingController();

  @override
  Widget build(BuildContext context) {
     width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
        backgroundColor: mainColor,
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .05,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * .03,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppRoutes.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .05,
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
                        SizedBox(
                          height: height * .03,
                        ),
                     Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              controller: pass,
                              pass: true,
                              width: width * .7,
                              title: "password",
                              number: false,
                              keyboardTypenumeric: false,
                              height: height * 08,
                            ),
                          ],
                        ),        SizedBox(
                          height: height * .03,
                        ),
                

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              controller: confirmPass,
                              pass: true,
                              width: width * .7,
                              title: "confirm password",
                              number: false,
                              keyboardTypenumeric: false,
                              height: height * 08,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: ()
                              {
                                AppRoutes.makeFirst(context, LoginScreen());
                              },
                              child: CustomButton(
                                width: width * .5,
                                height: height * .06,
                                color: mainColor,
                                title: "update",
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