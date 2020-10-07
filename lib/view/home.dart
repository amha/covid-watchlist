import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:covid19_app/model/watchlistModel.dart';
import 'package:covid19_app/view/global_snapshot.dart';
import 'package:covid19_app/view/offline.dart';
import 'package:covid19_app/view/safety_tips.dart';
import 'package:covid19_app/view/search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'country_detail.dart';
import 'search.dart';

class Watchlist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  int bottomNavigationIndex = 0;

  // check for network availability
  ConnectionState _connectionStatus;
  final Connectivity _networkWrapper = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    initConnectivity();
    _connectivitySubscription =
        _networkWrapper.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> viewPager = [
      GlobalSnapshot(),
      _buildMobile(context),
      SafetyTips()
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            iconTheme: Theme.of(context).appBarTheme.iconTheme,
            title: Text("$_connectionStatus"),
            backgroundColor: Theme.of(context).appBarTheme.color,
            actions: [
              IconButton(
                  icon: Icon(Icons.insert_chart),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GlobalSnapshot()));
                  }),
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: Delegate());
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
          body: _connectionStatus == ConnectionState.none ||
                  _connectionStatus == null
              ? Offline()
              : viewPager.elementAt(bottomNavigationIndex),
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
                onTap: (i) => {viewPagerController(i)}),
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

  // Widget _buildWeb(BuildContext context) {
  //   return Container(
  //     color: Color(0xFFF0F1F4),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Expanded(
  //           flex: 1,
  //           child: Container(
  //             color: Color(0xFFF0F1F4),
  //             child: _buildWebList(context),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 3,
  //           child: Container(
  //             color: Colors.white,
  //             child: _buildEmptyWatchlistScreen(context),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _buildMobile(BuildContext context) {
    return Consumer<WatchlistModel>(
        builder: (context, watchlist, child) => (watchlist.items.length == 0)
            ? _buildEmptyWatchlistScreen(context)
            : ListView.builder(
                itemCount: watchlist.items.length,
                itemExtent: 90,
                itemBuilder: (context, index) => ListTile(
                      title: Text(watchlist.items[index].name),
                      subtitle:
                          Text(watchlist.items[index].population.toString()),
                      leading: watchlist.items[index].hasFlag
                          ? Image.asset(
                              "assets/" + watchlist.items[index].name + ".png",
                              width: 48,
                            )
                          : Image.asset(
                              'assets/Default.png',
                              width: 48,
                            ),
                      trailing: Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: 80,
                          height: 100,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 50,
                                  child: Text(
                                    "+12%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CountryDetail(watchlist.items[index])));
                      },
                    )));
  }

  _buildEmptyWatchlistScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/empty_watchlist.gif',
          width: 400,
          height: 400,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            margin: EdgeInsets.all(0),
            alignment: Alignment.center,
            child: Text(
              "Build your watchlist",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
            )),
      ],
    );
  }

  // revisit responsive at a later stage
  // _buildWebList(BuildContext context) {
  //   //List savedCountries = Provider.of<WatchlistModel>(context).items.toList();
  //   return Text("We got nothing");
  // }

  // boilerplate from connectivity plug-in
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _networkWrapper.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  // boilerplate from connectivity plug-in
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        try {
          if (!kIsWeb && Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _networkWrapper.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _networkWrapper.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _networkWrapper.getWifiName();
            } else {
              wifiName = await _networkWrapper.getWifiName();
            }
          } else {
            wifiName = await _networkWrapper.getWifiName();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          if (!kIsWeb && Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _networkWrapper.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _networkWrapper.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _networkWrapper.getWifiBSSID();
            } else {
              wifiBSSID = await _networkWrapper.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _networkWrapper.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _networkWrapper.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = ConnectionState.active;
          // _connectionStatus = '$result\n'
          //     'Wifi Name: $wifiName\n'
          //     'Wifi BSSID: $wifiBSSID\n'
          //     'Wifi IP: $wifiIP\n';
        });
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = ConnectionState.none);
        break;
      default:
        setState(() => _connectionStatus = ConnectionState.none);
        break;
    }
  }
}
