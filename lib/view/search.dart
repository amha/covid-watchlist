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
          .map((e) => Country(e.value[0], e.value[1], e.value[2], e.value[3]))
          .toList();
    } else {
      // display entire list of countries
      suggestion = allCountries
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .startsWith(query.toLowerCase()))
          .toList();
      // List<Country> myList = [];
      // this
      //     .allCountries
      //     .forEach((key, value) => {myList.add()});
      // suggestion = this.allCountries.forEach((key, value) => {});
    }

    return ListView.builder(
        itemCount: suggestion.length,
        itemBuilder: (context, index) =>
            ListTileTheme(
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
                subtitle: Text("Total Cases: " + suggestion[index].totalCases),
                onTap: () {
                  List<Country> list = Provider
                      .of<WatchlistModel>(context,
                      listen: false)
                      .items
                      .where(
                          (element) => element.name == suggestion[index].name)
                      .toList();

                  // check if the selected country is already in the watchlist
                  if (list.isNotEmpty &&
                      countryChecker(suggestion[index], list[0])) {
                    // country exists, retrieve model and pass to detail route
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CountryDetail(list[index])));
                  } else {
                    // create new country model and pass to detail route
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CountryDetail(allCountries[index])));
                  }
                },
              ),
            ));
  }

  bool countryChecker(Country c1, Country c2) {
    print("comparing the following countries: $c1 and $c2");
    if (c1.name == c2.name) {
      return true;
    } else {
      return false;
    }
  }
}
