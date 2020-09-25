import 'package:covid19_app/Search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Model/Country.dart';
import 'country_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'C19 Tracker',
        theme: ThemeData(
          textTheme:
              GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.blue,
          primaryColorDark: Colors.blueAccent,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CountryList());
  }
}

class CountryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          'Covid 19 Watchlist',
          style: TextStyle(color: Colors.black87),
        ),
        bottomOpacity: 0.0,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Search()));
            },
          )
        ],
      ),
      body: ListView(
        children: [
          _buildRow(Country("United States", 66849689, true), context),
          Divider(height: 0.5, color: Colors.black26),
          _buildRow(Country("Ethiopia", 5739574, true), context),
          Divider(
            height: 0.5,
            color: Colors.black26,
          ),
          _buildRow(Country("Israel", 4385, true), context),
          Divider(
            height: 0.5,
            color: Colors.black26,
          ),
          _buildRow(Country("Kenya", 2943, true), context),
          Divider(
            height: 0.5,
            color: Colors.black26,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Search()));
        },
        label: Text('Add Countries'),
        icon: Icon(Icons.search),
        backgroundColor: Colors.pink,
      ),
    );
  }

  Widget _buildRow(Country country, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CountryDetail(country)));
      },
      child: Container(
        height: 90,
        width: 300,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8),
                width: 60,
                height: 60,
                child: Image.asset(
                  "assets/" + country.name + ".png",
                  width: 48,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country.population.toString() + " Infections",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.left,
                    ),
                    Text("485784 Number of deaths")
                  ],
                ),
              ),
            ),
            Expanded(
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
                        height: 25,
                        child: Text(
                          "+1,593",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
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
            )
          ],
        ),
      ),
    );
  }
}
