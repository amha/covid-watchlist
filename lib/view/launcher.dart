import 'dart:convert';

import 'package:covid19_app/model/covid_statistic.dart';
import 'package:covid19_app/utils/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Launcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void fetchData() async {
      final response = await http.get(
          'https://corona-virus-stats.herokuapp.com/api/v1/cases/general-stats');

      Map<String, dynamic> jsonResponse = jsonDecode(response.body)['data'];
      List<CovidStatistic> rates = [];

      jsonResponse.forEach((k, v) {
        CovidStatistic dataItem = new CovidStatistic(formatCovidStatName(k), v);
        rates.add(dataItem);
      });
      Future.delayed(const Duration(microseconds: 600), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Watchlist(rates)));
      });
    }

    fetchData();

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
