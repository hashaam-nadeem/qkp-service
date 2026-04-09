import 'dart:async';

import 'package:attendance/APIHELPEr/basehelper.dart';
import 'package:attendance/model/singleton.dart';
import 'package:attendance/model/usermodel.dart';
import 'package:attendance/screens/homepage.dart';
import 'package:attendance/screens/login.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/const.dart';
import 'package:attendance/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _splash();
  }
}

class _splash extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation curveAnimation;
  startTime() async {
    var duration = new Duration(seconds: 2);
    return Timer(duration, navigationpage);
  }

  void navigationpage() {
    AppRoutes.replace(context, LoginScreen());
  }

  _splashdelay() async {
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    curveAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticInOut,
    );
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.dispose();
        // APIHelper().getVersion(context);
        Future.delayed(Duration(seconds: 3), () async {
          getsharedprefdata();
        });
        // startTime();
        // getsharedprefdata();
        // startTime();
      }
    });
    _animationController.forward();
  }

  getsharedprefdata() async {
    await SharedPreferences.getInstance().then((onValue) {
      var email, password;
      setState(() {
        var token = (onValue.getString("token") ?? '');
        email = (onValue.getString("email") ?? '');
        password = (onValue.getString("password") ?? '');
        User.userData.token = token;

        // User.userData.lang = (onValue.getString("language") ?? '');
      });
      if (User.userData.token == null) {
        AppRoutes.makeFirst(context, LoginScreen());
      } else {
        getProfile(email, password);
      }
    });
  }

  getProfile(email, password) {
    BaseHelper().getProfile(email, password, context).then((value) {
      print("login response: $value");
      if (value['error'] == false) {
        UserDataModel userDataModel = UserDataModel();
        userDataModel = UserDataModel.fromJson(value['data']);
        setState(() {
          User.userData.userResult = userDataModel.result;
          User.userData.token = value['data']['token'];
        });
        print("token: ${User.userData.token}");
        setsharedpreferencedata(User.userData.token, email, password);
        AppRoutes.makeFirst(context, HomePage());
      } else {
        // showAlertDialog(context, "${value['message']}");
        AppRoutes.makeFirst(context, LoginScreen());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splashdelay();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      body: Stack(
        children: [
          PositionedTransition(
              rect: RelativeRectTween(
                      begin: RelativeRect.fromLTRB(0, 0, 0, 600),
                      end: RelativeRect.fromLTRB(0, 0, 0, 0))
                  .animate(curveAnimation),
              child: Container(
                margin: EdgeInsets.all(30), color:  Color(0xffF7F7F7),
                width: 100,
                height: 100,
                child: Image(
                  image: AssetImage('images/qkplogo.jpeg'),
                  // color: Colors.white,
                  height: MediaQuery.of(context).size.height * .5,
                ),
                // decoration:
                //     BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
              )),
        ],
      ),
    );
  }
}
