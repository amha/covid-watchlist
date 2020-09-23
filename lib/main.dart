import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

import 'country_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorDark: Colors.blueAccent,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Covid 19 Tracker',
            style: TextStyle(color: Colors.black87),
          ),
          bottomOpacity: 0.0,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.local_airport),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CountryDetail()));
              },
            )
          ],
        ),
        body: CountryList(),
      ),
    );
  }
}

class CountryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (ListView(
      children: [
        _buildRow("assets/USA.png", 66849689, context),
        Divider(height: 0.5, color: Colors.black26),
        _buildRow("assets/Ethiopia.png", 5739574, context),
        Divider(
          height: 0.5,
          color: Colors.black26,
        ),
        _buildRow("assets/Israel.png", 4385, context),
        Divider(
          height: 0.5,
          color: Colors.black26,
        ),
        _buildRow("assets/Kenya.png", 2943, context),
        Divider(
          height: 0.5,
          color: Colors.black26,
        ),
      ],
    ));
  }

  Widget _buildRow(String country, int death, BuildContext context) {
    var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CountryDetail()));
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
                child: Image.asset(country),
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
                      death.toString() + " Infections",
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
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        child: Sparkline(
                          data: data,
                          lineColor: Colors.green,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        height: 20,
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
