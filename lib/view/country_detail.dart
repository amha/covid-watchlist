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
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sectionTitle("Latest Numbers"),
              bigNumber("New Confirmed", widget.model.newConfirmed, true),
              bigNumber("Newly Recovered", widget.model.newRecovered, false),
              bigNumber("New Deaths", widget.model.newDeaths, false),
              sectionTitle("Aggregate Data"),
              bigNumber("Total Confirmed", widget.model.totalConfirmed, true),
              bigNumber("Total Recovered", widget.model.totalRecovered, false),
              bigNumber("Total Deaths", widget.model.totalDeaths, false)
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
                backgroundColor: Color(0x668B7CFF),
                foregroundColor: Colors.white,
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
              children: <Widget>[],
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

  Widget bigNumber(String label, String value, bool showBox) {
    return Container(
      height: 100,
      width: MediaQuery
          .of(context)
          .size
          .width - 40,
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
