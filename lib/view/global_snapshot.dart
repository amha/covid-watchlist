import 'package:covid19_app/model/covid_statistic.dart';
import 'package:covid19_app/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class GlobalSnapshot extends StatefulWidget {
  List<CovidStatistic> globalData = [];

  GlobalSnapshot(this.globalData);

  @override
  _GlobalSnapshopState createState() {
    return _GlobalSnapshopState();
  }
}

class _GlobalSnapshopState extends State<GlobalSnapshot> {
  List<CovidStatistic> data = [];

  @override
  void initState() {
    super.initState();
    data = widget.globalData;
  }

  @override
  Widget build(BuildContext context) {
    var dataPublishedOn = Jiffy()..subtract(days: 1);

    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sectionTitle("GLOBAL SNAPSHOT"),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 32),
          child: Text(
            "Data published on " + dataPublishedOn.yMMMMd.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        bigNumber(context, data[1].name, data[1].value, true),
        bigNumber(context, data[5].name, data[5].value, false),
        bigNumber(context, data[3].name, data[3].value, false),
        Divider(
          height: 1,
          color: Colors.white,
          thickness: .2,
          indent: 32,
          endIndent: 32,
        ),
        sectionTitle("YESTERDAY"),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 32),
          child: Text(
            "Reported in the last 24 hours",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        bigNumber(context, data[0].name, data[0].value, true),
        bigNumber(context, data[4].name, data[4].value, false),
        bigNumber(context, data[2].name, data[2].value, false),
      ],
    ));
  }
}
