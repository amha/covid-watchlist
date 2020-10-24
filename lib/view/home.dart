import 'package:covid19_app/model/country.dart';
import 'package:covid19_app/model/covid_statistic.dart';
import 'package:covid19_app/model/watchlistModel.dart';
import 'package:covid19_app/view/global_snapshot.dart';
import 'package:covid19_app/view/safety_tips.dart';
import 'package:covid19_app/view/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'country_detail.dart';
import 'search.dart';

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
            title: Text("Covid 19 Tracker"),
            backgroundColor: Theme.of(context).appBarTheme.color,
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: Delegate(widget.countryData));
                  }),
              IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () {
                  Provider.of<WatchlistModel>(context, listen: false)
                      .clearWatchlist();
                },
              )
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
                        trailing: Container(
                          width: 120,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                width: 120,
                                child: Text(
                                  "NEW CASES",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 120,
                                child: Text(
                                  watchlist.items[index].newCases,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
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
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation",
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          child: RaisedButton(
            // country in watchlist, display remove button
            padding: const EdgeInsets.all(20),
            textColor: Colors.white,
            color: Theme
                .of(context)
                .primaryColor,
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
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
