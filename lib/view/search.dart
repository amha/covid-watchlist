import 'package:covid19_app/model/country.dart';
import 'package:flutter/material.dart';

class Delegate extends SearchDelegate<String> {
  Map<String, List> allCountries;

  Delegate(this.allCountries);

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
      suggestion = suggestions.entries
          .map((e) => Country(e.value[0], e.value[1], e.value[2], e.value[3]))
          .toList();
    } else {
      suggestion = listOfCountries(allCountries)
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
        itemBuilder: (context, index) => ListTile(
              leading: suggestion[index].hasFlag
                  ? Image.asset(
                      'assets/' + suggestion[index].name + ".png",
                      width: 48,
                    )
                  : Icon(
                      Icons.local_airport_outlined,
                      color: Colors.blueGrey,
                    ),
              title: Text(
                suggestion[index].name,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text("Estimated Population: " +
                  suggestion[index].population.toString()),
              // onTap: () {
              //   List<Country> list = Provider.of<WatchlistModel>(context,
              //           listen: false)
              //       .items
              //       .where((element) => element.name == suggestion[index].name)
              //       .toList();
              //
              //   // check if the selected country is already in the watchlist
              //   if (list.isNotEmpty &&
              //       countryChecker(suggestion[index], list[0])) {
              //     // country exists, retrieve model and pass to detail route
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => CountryDetail(list[0])));
              //   } else {
              //     // create new country model and pass to detail route
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => CountryDetail(suggestion[index])));
              //   }
              // },
            ));
  }

  bool countryChecker(Country c1, Country c2) {
    if (c1.name == c2.name) {
      return true;
    } else {
      return false;
    }
  }
}
