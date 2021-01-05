// Copyright 2021 Amha Mogus. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

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
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Country> suggestion;
    suggestion = allCountries
        .where((element) => element.name
        .toString()
        .toLowerCase()
        .startsWith(query.toLowerCase()))
        .toList();

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
              List<Country> list = Provider.of<WatchlistModel>(context,
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
