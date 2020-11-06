import 'package:covid19_app/model/country.dart';
import 'package:covid19_app/model/covid_statistic.dart';
import 'package:covid19_app/model/watchlistModel.dart';
import 'package:covid19_app/view/about.dart';
import 'package:covid19_app/view/global_snapshot.dart';
import 'package:covid19_app/view/safety_tips.dart';
import 'package:covid19_app/view/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'country_detail.dart';
import 'search.dart';

enum menu { about, clear }

class Watchlist extends StatefulWidget {
  List<CovidStatistic> globalData = [];
  List<Country> countryData = [];

  @override
  State<StatefulWidget> createState() => _WatchlistState();

  Watchlist(this.globalData, this.countryData);
}

class _WatchlistState extends State<Watchlist> {
  Map<String, List> allCountries = {};

  int bottomNavigationIndex = 0;
  PageController controller =
      new PageController(initialPage: 0, keepPage: true);

  @override
  void initState() {
    super.initState();

    widget.countryData.forEach((element) {
      if (element.name != null) {
        var list = element.countryAsList();
        allCountries[element.name.toString()] = list;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      setState(() {});
    });
    List<Widget> viewPager = [
      GlobalSnapshot(widget.globalData),
      _buildMobile(context),
      SafetyTips()
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            iconTheme: Theme.of(context).appBarTheme.iconTheme,
            title: Text(
              "Covid 19 Watchlist",
              style: GoogleFonts.quicksand(),
            ),
            backgroundColor: Theme.of(context).appBarTheme.color,
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: Delegate(widget.countryData));
                  }),
              PopupMenuButton<String>(
                color: Colors.white,
                itemBuilder: (BuildContext context) {
                  return {'Clear Watchlist', 'About this app'}
                      .map((String selection) {
                    return PopupMenuItem(
                      value: selection,
                      child: Text(selection),
                    );
                  }).toList();
                },
                onSelected: (String value) {
                  switch (value) {
                    case 'Clear Watchlist':
                      Provider.of<WatchlistModel>(context, listen: false)
                          .clearWatchlist();
                      break;
                    case 'About this app':
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => About()));
                  }
                },
              ),
            ],
          ),
          body: PageView.builder(
              itemCount: viewPager.length,
              controller: controller,
              onPageChanged: (index) {
                bottomNavigationIndex = index;
              },
              itemBuilder: (context, bottomNavigationIndex) {
                return viewPager.elementAt(bottomNavigationIndex);
              }),
          bottomNavigationBar: SizedBox(
            height: 70,
            child: BottomNavigationBar(
                currentIndex: bottomNavigationIndex,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.location_on_outlined), label: 'Global'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), label: 'Watchlist'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.airline_seat_individual_suite_outlined),
                      label: 'Safety Tips'),
                ],
                onTap: (index) => {
                      controller.animateToPage(index,
                          duration: Duration(microseconds: 500),
                          curve: Curves.ease)
                    }),
          ),
        );
      },
    );
  }

  void viewPagerController(int position) {
    setState(() {
      bottomNavigationIndex = position;
    });
  }

  Widget _buildMobile(BuildContext context) {
    return Consumer<WatchlistModel>(
        builder: (context, watchlist, child) => (watchlist.items.length == 0)
            ? _buildEmptyWatchlistScreen(context)
            : ListView.builder(
                itemCount: watchlist.items.length,
                itemExtent: 80,
                itemBuilder: (context, index) => ListTileTheme(
                      contentPadding: EdgeInsets.all(16),
                      textColor: Colors.white,
                      child: ListTile(
                        title: Text(
                          watchlist.items[index].name,
                          style: TextStyle(fontSize: 20),
                        ),
                        leading: CircleAvatar(
                            backgroundColor: Color(0xFF332c47),
                            child: Text(
                              watchlist.items[index].countryCode.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                        subtitle: Text("Total Deaths: " +
                            watchlist.items[index].totalDeaths),
                        trailing: Container(
                          width: 85,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                          decoration: BoxDecoration(
                              color: Color(0xFFDAC9FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                width: 85,
                                child: Text(
                                  "NEW CASES",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 85,
                                child: Text(
                                  watchlist.items[index].newConfirmed,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  CountryDetail(watchlist.items[index])));
                        },
                      ),
                    )));
  }

  _buildEmptyWatchlistScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          alignment: Alignment.center,
          child: Icon(
            Icons.info_outline,
            size: 60,
            color: Colors.white,
          ),
        ),
        Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            margin: EdgeInsets.all(0),
            alignment: Alignment.center,
            child: Text(
              "Build your watchlist",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            )),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: Text(
            "Keep track of the pandemic by building a watchlist. A watchlist monitors the spread of the 19 virus at a country level. ",
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: 60,
          child: RaisedButton(
            // country in watchlist, display remove button
            padding: const EdgeInsets.all(20),
            textColor: Colors.white,
            color: Theme
                .of(context)
                .accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {
              showSearch(
                  context: context, delegate: Delegate(widget.countryData));
            },
            child: Text(
              "Add to Watchlist",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  String getLeading(String value) {
    String preview = "";
    int numberOfCharacters = value.characters.length;
    switch (numberOfCharacters) {
      case 1:
      case 2:
      case 3:
        preview = "100s";
        break;
      case 4:
        preview = value.substring(0, 1) + "K";
        break;
      case 5:
        preview = value.substring(0, 2) + "K";
        break;
      case 6:
        preview = value.substring(0, 3) + "K";
        break;
      default:
        preview = value.substring(0, 1) + "M";
        break;
    }
    return preview;
  }
}
