import 'dart:convert';

import 'package:covid19_app/model/country.dart';
import 'package:covid19_app/model/covid_statistic.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Launcher extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  List<CovidStatistic> globalValues = [];
  List<Country> countryValues = [];
  bool showButton = false;

  @override
  Widget build(BuildContext context) {
    var client = http.Client();

    void getStats() async {
      try {
        // fetch global data
        var globalData = await client.get('https://api.covid19api.com/summary');
        Map<String, dynamic> globalResponse =
            jsonDecode(globalData.body)['Global'];

        globalResponse.forEach((k, v) {
          CovidStatistic dataItem = new CovidStatistic(k, v.toString());
          globalValues.add(dataItem);
        });

        List<dynamic> countryResponse =
            jsonDecode(globalData.body)['Countries'];

        countryResponse
            .forEach((item) => {countryValues.add(new Country.fromJson(item))});
      } finally {
        client.close();
        Future.delayed(const Duration(microseconds: 600), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Watchlist(globalValues, countryValues)));
        });
      }
    }

    getStats();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/Play/logo.png",
              width: 220,
              height: 220,
            ),
            SizedBox(
              height: 10,
              width: 50,
              child: Container(
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Covid Watchlist",
                style: TextStyle(color: Colors.white, fontSize: 36),
              ),
            ),
            Text(
              "Stay informed. Stay health.",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.symmetric(vertical: 24),
              height: 100,
              width: 100,
              child: Visibility(
                visible: true,
                child: CircularProgressIndicator(
                    strokeWidth: 3,
                    backgroundColor: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
