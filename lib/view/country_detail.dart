import 'dart:convert';
import 'dart:core';

import 'package:covid19_app/model/country.dart';
import 'package:covid19_app/model/watchlistModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class CountryDetail extends StatefulWidget {
  final Country model;

  const CountryDetail(this.model);

  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  //bool isInWatchlist = false;
  int touchedIndex;
  List<dynamic> stats = [];
  double max = 0;
  var dataPublishedOn;

  void getCountryStats() async {
    var client = http.Client();
    String countryName = widget.model.name;

    try {
      // fetch global data
      var globalData = await client.get(
          "https://api.covid19api.com/country/'$countryName'?from=2020-10-19T00:00:00Z&to=2020-10-27T00:00:00Z");
      stats = jsonDecode(globalData.body);

      // globalResponse.forEach((element) {
      //   Map map = element;
      //   stats.add(map["Active"].toDouble());
      //
      //   if (map["Active"] > max) {
      //     max = map["Active"].toDouble();
      //   }
      // });
    } finally {
      client.close();
      Future.delayed(const Duration(microseconds: 600), () {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCountryStats();

    dataPublishedOn = Jiffy()..subtract(days: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: Theme.of(context).appBarTheme.iconTheme,
          title: Text(
            widget.model.name,
            style: Theme.of(context).appBarTheme.textTheme.headline6,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                child: Text(
                  "As of " + dataPublishedOn.yMMMMd.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: Theme
                    .of(context)
                    .primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Active Infections this week",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Color(0xFF8B7CFF),
                          ),
                          height: 240,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 40,
                          child: BarChart(mainBarData())),
                    ],
                  ),
                ),
              ),
              sectionTitle("Latest Numbers"),
              detailCard(
                  "Reported Yesterday", widget.model.newConfirmed, false),
              detailCard("Total Numbers", widget.model.newConfirmed, false),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  "This app is not responsible or liable for the content displayed herein. The producer of this app does not control the content, verify the content, and is in no way responsible for the content.",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: widget.model.inWatchList
            ? FloatingActionButton.extended(
          onPressed: () {
            Provider.of<WatchlistModel>(context, listen: false)
                .removeCountry(widget.model);
            _showMyDialog(false);
            setState(() {
              widget.model.inWatchList = false;
            });
          },
          label: Text("Remove from watchlist"),
          backgroundColor: Color(0xFFDAC9FF),
          foregroundColor: Colors.black,
        )
            : FloatingActionButton.extended(
          onPressed: () {
            Provider.of<WatchlistModel>(context, listen: false)
                .addCountry(widget.model);
            _showMyDialog(true);
            setState(() {
              widget.model.inWatchList = true;
            });
          },
          label: Text("Add to watchlist"),
          backgroundColor: Theme
              .of(context)
              .accentColor,
        ));
  }

  Future<void> _showMyDialog(bool isConfirmation) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isConfirmation
              ? Text(widget.model.name + ' added to watchlist')
              : Text(widget.model.name + 'removed from watchlist'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  isConfirmation
                      ? 'You can easily access the latest statistics from the Watchlist screen.'
                      : 'Alright. Your watchlist has been updated to reflect the removal of this country.',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          backgroundColor: Colors.white,
          contentTextStyle: TextStyle(color: Colors.white),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Okay',
                style: TextStyle(color: Color(0xFF8B7CFF)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  BarChartGroupData makeGroupData(int x,
      double y, {
        bool isTouched = false,
        Color barColor = Colors.white,
        double width = 22,
        List<int> showTooltips = const [],
      }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: max,
            colors: [Theme
                .of(context)
                .primaryColorDark
            ],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() =>
      List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 23, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 34, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 56, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 66, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 34, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 56, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 5, isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday, October 26';
                  break;
                case 1:
                  weekDay = 'Tuesday, October 27';
                  break;
                case 2:
                  weekDay = 'Wednesday, October 28';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                  TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  Widget detailCard(String title, String value, bool showBox) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 60,
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 40,
              padding: EdgeInsets.all(16),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recovered',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    widget.model.totalRecovered,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              )),
          Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Confirmed',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    widget.model.totalConfirmed,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              )),
          Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dead',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    widget.model.totalDeaths,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              )),
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
