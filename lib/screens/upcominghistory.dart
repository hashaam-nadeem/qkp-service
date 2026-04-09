import 'package:attendance/APIHELPEr/basehelper.dart';
import 'package:attendance/model/rostermodel.dart';
import 'package:attendance/utils/colors.dart';
import 'package:attendance/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UpcomingHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UpcomingHistory();
  }
}

class _UpcomingHistory extends State<UpcomingHistory> {
  var width, height;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
   ValueNotifier<RosterModel> _dataNotifier =
      ValueNotifier<RosterModel>(null);
 int page=1;
       @override
  void initState() {
    super.initState();
   BaseHelper().getSchdule(context,_dataNotifier,page);
  }


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return    ValueListenableBuilder(
        valueListenable: _dataNotifier, builder: (context, value, child) {
            if (value!=null) {
            return Container(
              width: width,
              height: height,
              child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () {
                  if(page>=1)
                  {
                     setState(() {
                    // value.currentPage = value.currentPage + 1;
                    page=page-1;
                  print("current page: ${value.currentPage}");
                  });
                    BaseHelper().getSchdule(context,_dataNotifier,page);
                     _refreshController.refreshCompleted();
                  }
                  // _refreshController.loadComplete();
                },
                onLoading: () {
                  // print("loading");
                  if(page<value.lastpage)
                  {
                     setState(() {
                    value.currentPage = value.currentPage + 1;
                    page=page+1;
                  print("current page: ${value.currentPage}");
                  });
                    BaseHelper().getSchdule(context,_dataNotifier,page);
                     _refreshController.loadComplete();
                  }
                 
                  // print("updated page count: $page");
                  // getAllProducts();
                 
                },
                child: ListView.builder(
                    itemCount: value.result.length,
                    itemBuilder: (context, int index) {
                      return value.result[index].status == 1
                          ? currentHistory(value.result, index)
                          : Container();
                    }),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        });
   
  }

  currentHistory(snapshot, index) {
    return Container(
      margin: EdgeInsets.only(bottom: height * .02),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * .02), color: mainColor),
      padding: EdgeInsets.all(width * .02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shift Start: ${snapshot[index].userResult.shiftStart}",
                style: headingStyle.copyWith(
                    fontSize: 18, color: Colors.grey[200]),
              ),
              Text(
                "Shift End: ${snapshot[index].userResult.shiftEnd}",
                style: headingStyle.copyWith(
                    fontSize: 18, color: Colors.grey[200]),
              )
            ],
          ),
          SizedBox(
            height: height * .02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date from: ${snapshot[index].dateFrom}",
                style: headingStyle.copyWith(
                    fontSize: 18, color: Colors.grey[200]),
              ),
              Text(
                "Date to: ${snapshot[index].dateFrom}",
                style: headingStyle.copyWith(
                    fontSize: 18, color: Colors.grey[200]),
              )
            ],
          ),
          // SizedBox(
          //   height: height * .02,
          // ),
          // Row(
          //   children: [
          //     Text(
          //       "client Name: ${snapshot[index].userResult.clientName}",
          //       style: headingStyle.copyWith(fontSize: 16, color: Colors.white),
          //     )
          //   ],
          // ),
          SizedBox(
            height: height * .02,
          ),
          Row(
            children: [
              Text(
                "${snapshot[index].userResult.siteName}",
                style: headingStyle.copyWith(fontSize: 16, color: Colors.white),
              )
            ],
          ),
          SizedBox(
            height: height * .02,
          ),
          Row(
            children: [
              Flexible(
                  child: Text(
                "Remarks: ${snapshot[index].userResult.remarks}",
                style: headingStyle.copyWith(fontSize: 16, color: Colors.white),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
