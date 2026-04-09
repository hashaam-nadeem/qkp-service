import 'package:attendance/APIHELPEr/basehelper.dart';
import 'package:attendance/model/singleton.dart';
import 'package:attendance/model/usermodel.dart';
import 'package:attendance/screens/login.dart';
import 'package:attendance/screens/sendotp.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/const.dart';
import 'package:attendance/utils/custombutton.dart';
import 'package:attendance/utils/customtextfield.dart';
import 'package:attendance/utils/route.dart';
import 'package:attendance/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forgotpassword.dart';
import 'homepage.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _languageScreen();
  }
}

class _languageScreen extends State<RegisterScreen> {
  var width, height;
  bool remember = false;
  bool isNumber = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * .2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/qkplogo.jpeg'),
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  Text("\tSmart Task",
                      style: headingStyle.copyWith(
                          fontSize: height * .06,
                          // fontWeight:FontWeight.bold,
                          color: Colors.white))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                        "Employee Scheduling and Mobile WorkForce Management",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: headingStyle.copyWith(
                            fontSize: height * .02,
                            // fontWeight:FontWeight.bold,
                            color: Colors.white)),
                  )
                ],
              ),
              SizedBox(
                height: height * .06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: name,
                    pass: false,
                    width: width * .85,
                    number: true,
                    keyboardTypenumeric: false,
                    title: "Name",
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
                  CustomTextField(
                    controller: email,
                    pass: false,
                    width: width * .85,
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
                  CustomTextField(
                    controller: password,
                    pass: true,
                    width: width * .85,
                    title: "password",
                    number: false,
                    keyboardTypenumeric: false,
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
                  CustomTextField(
                    controller: confirmPassword,
                    pass: true,
                    width: width * .85,
                    title: "Confirm password",
                    number: false,
                    keyboardTypenumeric: false,
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
                    onTap: () {
                      email.clear();
                      password.clear();
                    },
                    child: CustomButton(
                      width: width * .4,
                      height: height * .06,
 color: secondaryColor,
                      title: "Clear",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (email.text.trim().isEmpty ||
                          password.text.trim().isEmpty ||
                          name.text.trim().isEmpty ||
                          confirmPassword.text.trim().isEmpty) {
                        showAlertDialog(
                            context, "Please enter required fields!");
                      } else if (confirmPassword.text != password.text) {
                        showAlertDialog(context, "{Password doesn't match!");
                      } else {
                        BaseHelper()
                            .registerUser(
                                name.text, email.text, password.text, context)
                            .then((value) {
                          print("login response: $value");
                          if (value
                              .toString()
                              .contains("The email has already been taken")) {
                            showAlertDialog(
                                context, "The email has already been taken");
                          }
                         else {
                           showAlertDialog(
                                context, "Successfully Registered!");
                            AppRoutes.makeFirst(context, LoginScreen());
                          }

                          //  AppRoutes.push(context, HomePage());
                        });
                      }
                      //  AppRoutes.push(context, HomePage());
                    },
                    child: CustomButton(
                      width: width * .4,
                      height: height * .06,
                      color: secondaryColor,
                      title: "SIGN UP",
                    ),
                  ),
                ],
              ),
              //  SizedBox(
              //    height: height * .03,
              //  ),
              //  Row(
              //    mainAxisAlignment: MainAxisAlignment.center,
              //    children: [
              //      GestureDetector(
              //        onTap: () {
              //          AppRoutes.push(context, SendOtp());
              //        },
              //        child: Text(
              //          "Forgot Password?",
              //          style: headingStyle.copyWith(
              //              color: Colors.white,
              //              fontSize: height * .02),
              //        ),
              //      ),
              //    ],
              //  ),
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppRoutes.makeFirst(context, LoginScreen());
                    },
                    child: Text("Already have an account? Login",
                        style: headingStyle.copyWith(
                            fontSize: height * .025,
                            fontWeight: FontWeight.bold,
                             color: secondaryColor,)),
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
