import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, //Color(0xe9eaf6),
        appBar: AppBar(
          title: Text("About"),
          elevation: 0,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                child: Text(
                  "Motivation",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                alignment: Alignment.center,
                child: Text(
                  'News coverage of the pandemic is nearly identical to news coverage of the stock market. A measurement, for instance, is identified and presented within a dramatic frame that behaviorally informs or entertains or both. I decided to remove journalistic forms in the app’s presentation.',
                  style: TextStyle(fontSize: 16, height: 2),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                alignment: Alignment.center,
                child: Text(
                  'In doing so, the experience abandons narrative; the emphasis here is purely quantitative. The presentation should be familiar to anyone who monitors the stock market. Aside from a few deliberate ‘specials’ or lists of ‘notable people’, we don’t have a good way of engaging with the human, qualitative aspect, of the pandemic. ',
                  style: TextStyle(fontSize: 16, height: 2),
                ),
              ),
            ],
          ),
        ));
  }
}
