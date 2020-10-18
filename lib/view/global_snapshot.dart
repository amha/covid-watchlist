import 'package:covid19_app/model/covid_statistic.dart';
import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sectionTitle("LATEST NUMBERS"),
        bigNumber(data[0].name, data[0].value, true),
        bigNumber(data[1].name, data[1].value, false),
        bigNumber(data[2].name, data[2].value, false),
        Divider(
          height: 1,
          color: Colors.white,
          thickness: .2,
          indent: 32,
          endIndent: 32,
        ),
        sectionTitle("INFECTIONS"),
        bigNumber(data[4].name, data[4].value, true),
        bigNumber(data[5].name, data[5].value, false),
        bigNumber(data[5].name, data[5].value, false),
        bigNumber(data[5].name, data[5].value, false),
      ],
    ));
  }

  Widget bigNumber(String label, String value, bool showBox) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width - 40,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: showBox ? Color(0xFF8B7CFF) : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$label',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900)),
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        "$title",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xFF8B7CFF)),
      ),
    );
  }
}
