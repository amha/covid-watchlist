import 'package:flutter/material.dart';

class CountryDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 30,
            child: Center(
              child: Text(
                "Ethiopia",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
            ),
          )
        ],
      ),
    );
  }
}
