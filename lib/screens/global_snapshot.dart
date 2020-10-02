import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GlobalSnapshot extends StatefulWidget {
  @override
  _GlobalSnapshopState createState() {
    return _GlobalSnapshopState();
  }
}

class _GlobalSnapshopState extends State<GlobalSnapshot> {
  void fetchData() async {
    final response = await http.get('https://api.exchangeratesapi.io/latest');
    Map<String, dynamic> responseJson = jsonDecode(response.body)['rates'];

    List<CurrencyDataItem> rates = [];

    responseJson.forEach((k, v) {
      CurrencyDataItem dataItem = new CurrencyDataItem(k, v);
      rates.add(dataItem);
    });
    setState(() {
      data = rates;
    });
  }

  List<CurrencyDataItem> data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // determine if we're in mobile or greater
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Global Snapshot"),
        backgroundColor: Theme.of(context).appBarTheme.color,
        elevation: Theme.of(context).appBarTheme.elevation,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: data.length == 0
            ? Text("Nothing to display")
            : GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: width > 450 ? 5 : 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          data[index].name,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(data[index].value.toString(),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 40,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).accentColor,
          onPressed: () {
            setState(() {
              fetchData();
            });
          },
          icon: Icon(Icons.download_rounded),
          label: Text("GET DATA")),
    );
  }
}

class CurrencyDataItem {
  String name;
  double value;

  CurrencyDataItem(this.name, this.value);
}
