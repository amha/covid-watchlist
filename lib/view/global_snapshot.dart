import 'dart:convert';

import 'package:covid19_app/model/covid_statistic.dart';
import 'package:covid19_app/utils/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class GlobalSnapshot extends StatefulWidget {
  @override
  _GlobalSnapshopState createState() {
    return _GlobalSnapshopState();
  }
}

class _GlobalSnapshopState extends State<GlobalSnapshot> {
  void fetchData() async {
    final response = await http.get(
        'https://corona-virus-stats.herokuapp.com/api/v1/cases/general-stats');

    Map<String, dynamic> jsonResponse = jsonDecode(response.body)['data'];
    List<CovidStatistic> rates = [];

    jsonResponse.forEach((k, v) {
      CovidStatistic dataItem = new CovidStatistic(formatCovidStatName(k), v);
      rates.add(dataItem);
    });
    setState(() {
      data = rates;
    });
  }

  List<CovidStatistic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Global Snapshot"),
        backgroundColor: Theme.of(context).appBarTheme.color,
        elevation: Theme.of(context).appBarTheme.elevation,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: data.length == 0
              ? Expanded(
                  child: Container(
                  child: Text(
                    "Loading",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide.none,
                                right: BorderSide.none,
                                left: BorderSide.none,
                                bottom: BorderSide(
                                    width: 0.0,
                                    color: Theme.of(context).accentColor))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  height: 72,
                                  alignment: Alignment.centerLeft,
                                  child: Text(data[index].name,
                                      style: GoogleFonts.quicksand(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2))),
                            ),
                            Expanded(
                                child: Container(
                              height: 72,
                              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                              alignment: Alignment.centerRight,
                              child: Text(
                                data[index].value,
                                style: GoogleFonts.quicksand(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                            ))
                          ],
                        ),
                      ))),
    );
  }
}
