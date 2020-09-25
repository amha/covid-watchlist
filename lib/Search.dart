import 'package:covid19_app/Model/Country.dart';
import 'package:flutter/material.dart';

import 'country_detail.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Delegate());
            },
          )
        ],
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 120, 0, 16),
                height: 200,
                width: 200,
                child: Image.asset('assets/search.png')),
            Text(
              "Search by country name",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(32, 16, 32, 10),
              child: Text(
                "You can add countries to your watchlist and track their progress.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Delegate extends SearchDelegate<String> {
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
          .map((e) => Country(e.key, e.value[0], e.value[1]))
          .toList();
    } else {
      suggestion = listOfCountries(allCountries)
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .startsWith(query.toLowerCase()))
          .toList();
    }

    return ListView.builder(
        itemCount: suggestion.length,
        itemBuilder: (context, index) => ListTile(
              leading: suggestion[index].hasFlag
                  ? Image.asset(
                      'assets/' + suggestion[index].name + ".png",
                      width: 48,
                    )
                  : Image.asset(
                      'assets/Default.png',
                      width: 40,
                    ),
              title: Text(
                suggestion[index].name,
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text("Estimated Population: " +
                  suggestion[index].population.toString()),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        CountryDetail(suggestion[index])));
              },
            ));
  }
}
