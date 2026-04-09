import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/route.dart';
import 'package:attendance/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showAlertDialog(BuildContext context, message) async {

  return   showDialog(
      context: context,
      builder:(context)=> AlertDialog(
        backgroundColor: Colors.transparent,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(15.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: Container(
            width: MediaQuery.of(context).size.width * .7,
            height: MediaQuery.of(context).size.height * .3,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .7,
                    height: MediaQuery.of(context).size.height * .25,
                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              .04),
                                      color: mainColor),
                    // color: mainColor,
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .02),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .07,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "$message",
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: headingStyle.copyWith(
                                    fontSize: 14, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                AppRoutes.pop(context);
                                // AppRoutes.push(context, LoginScreen(
                                //   screen: 0,
                                // ));
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                  width:
                                      MediaQuery.of(context).size.width * .25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              .02),
                                      color: Colors.white),
                                  child: Center(
                                    child: Text(
                                      "OK",
                                      textAlign: TextAlign.center,
                                      style: headingStyle.copyWith(
                                          fontSize: 16, color: mainColor),
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
                    width: MediaQuery.of(context).size.width * .25,
                    height: MediaQuery.of(context).size.height * .12,
                    
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, 
                        image: DecorationImage(
                          image: AssetImage("images/qkplogo.jpeg"),fit: BoxFit.contain
                        ),
                        color: mainColor),
                    
                  ),
                ),
       
              ],
            )),
      ));

//   showDialog<void>(
//     context: context,
//     barrierDismissible: true, // user must tap button!
//     builder: (BuildContext context) {
//       return CupertinoAlertDialog(
//         title: Text('Message'),
//         content: Text('$message!'),
//         actions: <Widget>[
//           CupertinoDialogAction(
//             child: Text('ok'),
//             onPressed: () {
//               Navigator.of(context).pop();
// //                Navigator.pushReplacement(
// //                  context,
// //                  new MaterialPageRoute(builder: (context) => MainScreen()),
// //                );
//             },
//           ),
//         ],
//       );
//     },
//   );

}

void setsharedpreferencedata(String token, email, password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", token);
  await prefs.setString("email", email);
  await prefs.setString("password", password);
}
