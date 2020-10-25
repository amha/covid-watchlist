import 'package:covid19_app/model/country.dart';
import 'package:covid19_app/model/watchlistModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'country_detail.dart';

class Delegate extends SearchDelegate<String> {
  List<Country> allCountries;

  Delegate(this.allCountries);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // displayed after search has been tapped
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Country> suggestion;
    if (query.isEmpty) {
      // show recent searches
      suggestion = suggestions.entries
          .map((e) => Country(e.value[0], e.value[1], e.value[2], e.value[3],
              e.value[4], e.value[5], e.value[6], "test", false))
          .toList();
    } else {
      // display entire list of countries
      suggestion = allCountries
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .startsWith(query.toLowerCase()))
          .toList();
    }

    return ListView.builder(
        itemCount: suggestion.length,
        itemBuilder: (context, index) => ListTileTheme(
              textColor: Colors.white,
              tileColor: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.local_airport_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  suggestion[index].name,
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle:
                Text("Total Cases: " + suggestion[index].totalConfirmed),
                onTap: () {
                  List<Country> list = Provider
                      .of<WatchlistModel>(context,
                      listen: false)
                      .items
                      .where(
                          (element) => element.name == suggestion[index].name)
                      .toList();

                  // check if current country has been added to the watchlist
                  int val = list.indexWhere(
                          (element) => element.name == suggestion[index].name);

                  if (list.isNotEmpty && val != -1) {
                    // current country is in watchlist
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CountryDetail(list[val])));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CountryDetail(suggestion[index])));
                  }
                },
              ),
            ));
  }
}
