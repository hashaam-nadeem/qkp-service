import 'package:attendance/APIHELPEr/basehelper.dart';
import 'package:attendance/model/singleton.dart';
import 'package:attendance/model/usermodel.dart';
import 'package:attendance/screens/register.dart';
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

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _languageScreen();
  }
}

class _languageScreen extends State<LoginScreen> {
  var width, height;
  bool show = false;
  bool remember = false;
  final _formKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formKey,
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
                      // color: Colors.white,
                      height: MediaQuery.of(context).size.height * .08,
                    ),
                    Text("\tQk9 Services",
                        style: headingStyle.copyWith(
                          fontSize: height * .06,
                          // fontWeight:FontWeight.bold,
                          color: secondaryColor,
                        ))
                  ],
                ),
                SizedBox(
                  height: height * .02,
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
                    Container(
                      width: width * .85,
                      height: height * .09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .02),
                        border: Border.all(color: Colors.white),
                        color: Colors.white,
                      ),
                      // padding: ,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email!';
                          }
                          return null;
                        },
                        textAlign: TextAlign.left,
                        controller: email,

                        // maxLength: widget.number == true ? 8 : 40,
                        style: labelTextStyle.copyWith(
                            // color: secondaryColor,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                        // obscureText: widget.pass == true
                        //     ? show == false
                        //         ? true
                        //         : false
                        //     : false,
                        decoration: InputDecoration(
                            border: InputBorder.none,

                            // contentPadding: EdgeInsets.all(width * .05),
                            // counterText: "",
                            hintText: "Email",
                            prefixIcon: Icon(
                              Icons.person,
                              size: height * .05,
                            ),
                            // suffixIcon: GestureDetector(
                            //   onTap: () {
                            //     email.clear();
                            //   },
                            //   child: Icon(
                            //     Icons.close,
                            //     size: 20,
                            //   ),
                            // ),

                            // labelText: "${widget.title}",
                            hintStyle: labelTextStyle.copyWith(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal)),
                      ),
                    )

                    // CustomTextField(
                    //   controller: email,
                    //   pass: false,
                    //   width: width * .85,
                    //   number: true,
                    //   keyboardTypenumeric: false,
                    //   title: "Email",
                    //   height: height * 08,
                    // ),
                  ],
                ),
                SizedBox(
                  height: height * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * .85,
                      height: height * .09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * .02),
                        border: Border.all(color: Colors.white),
                        color: Colors.white,
                      ),
                      // padding: ,
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password!';
                          }
                          return null;
                        },

                        // maxLength: widget.number == true ? 8 : 40,
                        style: labelTextStyle.copyWith(
                            // color: secondaryColor,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                        obscureText: show == false ? true : false,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.all(width * .08),
                            // counterText: "",
                            hintText: "password",
                            prefixIcon: Icon(
                              Icons.lock,
                              size: height * .05,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  show = !show;
                                });
                              },
                              child: Icon(
                                show == false
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20,
                              ),
                            ),

                            // labelText: "${widget.title}",
                            hintStyle: labelTextStyle.copyWith(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal)),
                      ),
                    )

                    // CustomTextField(
                    //   controller: password,
                    //   pass: true,
                    //   width: width * .85,
                    //   title: "password",
                    //   number: false,
                    //   keyboardTypenumeric: false,
                    //   height: height * 08,
                    // ),
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
                        // showAlertDialog(context,"sa");
                        if (_formKey.currentState.validate()) {
                          BaseHelper()
                              .login(email.text, password.text, context)
                              .then((value) {
                            print("login response: $value");
                            if (value['error'] == false) {
                              UserDataModel userDataModel = UserDataModel();
                              userDataModel =
                                  UserDataModel.fromJson(value['data']);
                              setState(() {
                                User.userData.userResult = userDataModel.result;
                                User.userData.token = value['data']['token'];
                              });
                              print("token: ${User.userData.token}");
                              setsharedpreferencedata(User.userData.token,
                                  email.text, password.text);
                              AppRoutes.makeFirst(context, HomePage());
                            } else {
                              showAlertDialog(context, "${value['message']}");
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
                        title: "SIGN IN",
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
                  //  mainAxisAlignment: MainAxisAlignment.c,
                  children: [
                    SizedBox(
                      width: width * .1,
                    ),
                    Switch(
                        activeColor: Colors.white,
                        hoverColor: Colors.white,
                        inactiveTrackColor: lightmainColor,
                        value: remember,
                        onChanged: (value) {
                          setState(() {
                            remember = !remember;
                          });
                        }),
                    Text("\tRemember Me",
                        style: headingStyle.copyWith(
                          fontSize: height * .025,
                          // fontWeight:FontWeight.bold,
                          color: secondaryColor,
                        ))
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                // Row(
                //    mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: ()
                //       {
                //         AppRoutes.makeFirst(context, RegisterScreen());
                //       },
                //       child: Text("Don't have an account? Sign Up",
                //           style: headingStyle.copyWith(
                //               fontSize: height * .025,
                //               fontWeight:FontWeight.bold,
                //                color: secondaryColor,)),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
