import 'dart:convert';

import 'package:covid19_app/model/country.dart';
import 'package:covid19_app/model/covid_statistic.dart';
import 'package:covid19_app/utils/text_formatter.dart';
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
        var globalData = await client.get(
            'https://corona-virus-stats.herokuapp.com/api/v1/cases/general-stats');
        Map<String, dynamic> globalResponse =
            jsonDecode(globalData.body)['data'];

        globalResponse.forEach((k, v) {
          CovidStatistic dataItem =
              new CovidStatistic(formatCovidStatName(k), v);
          globalValues.add(dataItem);
        });

        // fetch country data
        var countryData = await client.get(
            'https://corona-virus-stats.herokuapp.com/api/v1/cases/countries-search?limit=100');
        List<dynamic> countryResponse =
            jsonDecode(countryData.body)['data']['rows'];

        countryResponse
            .forEach((item) => {countryValues.add(new Country.fromJson(item))});
      } finally {
        client.close();
        Future.delayed(const Duration(microseconds: 600), () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Watchlist(globalValues, countryValues)));
        });
      }
    }

    getCovidStats();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
