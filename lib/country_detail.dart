import 'package:covid19_app/Model/Country.dart';
import 'package:covid19_app/Model/watchlistModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryDetail extends StatefulWidget {
  final Country model;

  const CountryDetail(this.model);

  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  GlobalKey key = new GlobalKey();
  bool isInWatchlist;

  @override
  void initState() {
    super.initState();
    this.isInWatchlist = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              //TODO
            },
          ),
          IconButton(
            icon: Icon(Icons.feedback),
            onPressed: () {
              //TODO
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 90,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 6,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/" + widget.model.name.toString() + ".png",
                      width: 48,
                    ),
                    height: 120,
                    padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.model.name.toUpperCase(),
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w800)),
                        Text(
                          "Est. Population: " +
                              widget.model.population.toString(),
                          style: TextStyle(color: Colors.black87),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: (size.width / 2) - 22,
                    margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
                    padding: EdgeInsets.fromLTRB(16, 4, 4, 8),
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 6,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "10",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w200,
                              color: Colors.white),
                        ),
                        Text(
                          "Total Deaths",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 90,
                    width: (size.width / 2) - 22,
                    margin: EdgeInsets.fromLTRB(4, 0, 8, 8),
                    padding: EdgeInsets.fromLTRB(16, 4, 4, 8),
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 6,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "29k",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w200,
                              color: Colors.white),
                        ),
                        Text(
                          "Total Infections",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //     height: 240,
            //     margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
            //     padding: EdgeInsets.all(16),
            //     decoration: BoxDecoration(
            //         color: Colors.grey[50],
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(8),
            //         ),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.15),
            //             spreadRadius: 6,
            //             blurRadius: 5,
            //             offset: Offset(0, 3), // changes position of shadow
            //           ),
            //         ]),
            //     child: Column(
            //       children: [
            //         Container(
            //           child: Text(
            //             "Infections: last 7 days",
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
            //         ),
            //         Container(
            //           margin: EdgeInsets.all(16),
            //           height: 80,
            //           child: Sparkline(
            //             data: [
            //               0.0,
            //               1.0,
            //               1.5,
            //               2.0,
            //               1.0,
            //               1.5,
            //               -0.5,
            //               -1.0,
            //               -0.5,
            //               0.0,
            //               -0.5,
            //               -1.0,
            //               -0.5,
            //               0.0,
            //             ],
            //             lineColor: Colors.green,
            //           ),
            //         ),
            //         Row(
            //           children: [
            //             Icon(Icons.account_circle),
            //             Text(
            //               "  Cases per 10k: 134   ",
            //               style: TextStyle(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w200,
            //               ),
            //             ),
            //             Icon(Icons.apps),
            //             Text(
            //               "  No. of tests: 25k",
            //               style: TextStyle(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w200,
            //               ),
            //             ),
            //           ],
            //         )
            //       ],
            //     )),
            Container(
              margin: EdgeInsets.all(16),
              width: size.width - 32,
              child: widget.model.inWatchList
                  ? RaisedButton(
                      // country in watchlist, display remove button
                      padding: const EdgeInsets.all(20),
                      textColor: Colors.white,
                      color: Colors.red[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      onPressed: () {
                        //Scaffold.of(context).showSnackBar(countryRemovedSnackBar);
                        Provider.of<WatchlistModel>(context, listen: false)
                            .removeCountry(widget.model);
                      },
                      child: Text(
                        "Remove from Watchlist",
                        style: TextStyle(
                            color: Colors.red[800],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : RaisedButton(
                      // Country not in watchlist, display add button
                      padding: const EdgeInsets.all(20),
                      textColor: Colors.white,
                      color: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onPressed: () {
                        _showDialog();
                        widget.model.addToWatchlist();
                        Provider.of<WatchlistModel>(context, listen: false)
                            .addCountry(widget.model);
                        setState(() {
                          this.isInWatchlist = true;
                        });
                      },
                      child: Text(widget.model.inWatchList
                          ? 'Latest health tips'
                          : "Add to Watchlist"),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Added to Watchlist"),
          content: new Text("Nice. Keep building."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
