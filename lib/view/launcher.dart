import 'dart:convert';

import 'package:covid19_app/model/country.dart';
import 'package:covid19_app/model/covid_statistic.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Launcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var client = http.Client();

    void getCovidStats() async {
      List<CovidStatistic> globalValues = [];
      List<Country> countryValues = [];

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

    getCovidStats();

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
            Text(
              "Covid19 Tracker",
              style: TextStyle(color: Colors.white, fontSize: 48),
            ),
            Container(
              padding: EdgeInsets.all(24),
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                  strokeWidth: 3, backgroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
