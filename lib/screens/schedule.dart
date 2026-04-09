import 'package:attendance/APIHELPEr/basehelper.dart';
import 'package:attendance/model/rostermodel.dart';
import 'package:attendance/screens/currentHistory.dart';
import 'package:attendance/screens/upcominghistory.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/custombutton.dart';
import 'package:attendance/utils/route.dart';
import 'package:attendance/utils/styles.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScheduleScreen();
  }
}

class _ScheduleScreen extends State<ScheduleScreen> {
  var width, height;
  bool history=false;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: GestureDetector(
          onTap: () {
            AppRoutes.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(width * .01),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        history=false;
                      });
                    },
                    child: CustomButton(
                      width: width * .45,
                      height: height * .06,
                      color:history==false?mainColor: secondaryColor,
                      title: "History",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                       setState(() {
                        history=true;
                      });
                    },
                    child: CustomButton(
                      width: width * .45,
                      height: height * .06,
                      color: history==true?mainColor: secondaryColor,
                      title: "Current/Upcoming",
                    ),
                  ),
                ],
              ),
          SizedBox(
            height: height*.02,
          ),
          Expanded(
            child:history==false?
            CurrentHistory()
            :UpcomingHistory(),
          ),
            ],
          )),
    );
  }

}
