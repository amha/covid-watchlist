import 'package:covid19_app/model/country.dart';
import 'package:covid19_app/model/watchlistModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryDetail extends StatefulWidget {
  final Country model;

  const CountryDetail(this.model);

  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  //bool isInWatchlist = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: Theme.of(context).appBarTheme.iconTheme,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              bigNumber(widget.model.name, widget.model.newCases, true),
              bigNumber("Total Cases", widget.model.totalCases, true),
              bigNumber("Active Cases", widget.model.activeCases, false),
              bigNumber("Total Recovered", widget.model.newCases, false),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: widget.model.inWatchList
            ? FloatingActionButton.extended(
                onPressed: () {
                  Provider.of<WatchlistModel>(context, listen: false)
                      .removeCountry(widget.model);
                  setState(() {
                    widget.model.inWatchList = false;
                  });
                },
                label: Text("Remove from watchlist"),
                backgroundColor: Color(0x668B7CFF),
                foregroundColor: Colors.white,
              )
            : FloatingActionButton.extended(
                onPressed: () {
                  Provider.of<WatchlistModel>(context, listen: false)
                      .addCountry(widget.model);
                  setState(() {
                    widget.model.inWatchList = true;
                  });
                },
                label: Text("Add to watchlist"),
                backgroundColor: Theme.of(context).accentColor,
              ));
  }

  Widget bigNumber(String label, String value, bool showBox) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width - 40,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: showBox ? Color(0xFF8B7CFF) : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$label',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900)),
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
