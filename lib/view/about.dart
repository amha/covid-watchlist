import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, //Color(0xe9eaf6),
        appBar: AppBar(
          title: Text(
            "About",
            style: GoogleFonts.quicksand(),
          ),
          elevation: 0,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: 200,
                color: Theme
                    .of(context)
                    .primaryColor,
                margin: EdgeInsets.symmetric(vertical: 0),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                child: Icon(
                  Icons.info_rounded,
                  color: Colors.black87,
                  size: 46,
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  "Motivation",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 50,
                height: 10,
                child: Container(
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 36),
                alignment: Alignment.center,
                child: Text(
                  'News coverage of the pandemic is nearly identical to news coverage of the stock market. A measurement or data point is isolated and presented within a dramatic frame that informs, entertains or tries to do both. I decided to remove journalistic forms in the app’s presentation.',
                  style: TextStyle(fontSize: 16, height: 2),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 36),
                alignment: Alignment.center,
                child: Text(
                  'In doing so, the experience abandons narrative; the emphasis here is purely quantitative. The presentation should be familiar to anyone who monitors the stock market. Aside from a few deliberate ‘specials’ or lists of ‘notable people’, we don’t have a good way of engaging with the human, qualitative aspect, of the pandemic. ',
                  style: TextStyle(fontSize: 16, height: 2),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Divider(
                  height: 1,
                  color: Colors.black,
                  thickness: .2,
                  indent: 32,
                  endIndent: 32,
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  "The Data",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 50,
                height: 10,
                child: Container(
                  color: Theme
                      .of(context)
                      .primaryColorDark,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Text(
                        'All data presented in this app can be accessed by tapping the following button:',
                        style: TextStyle(fontSize: 16, height: 2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: ButtonTheme(
                        height: 50,
                        child: RaisedButton.icon(
                          elevation: 7,
                          color: Theme
                              .of(context)
                              .backgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          label: Text("View API"),
                          icon: Icon(Icons.add_to_home_screen_outlined),
                          onPressed: () {
                            _getWebpage();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Divider(
                  height: 1,
                  color: Colors.black,
                  thickness: .2,
                  indent: 32,
                  endIndent: 32,
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  "Tools",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 50,
                height: 10,
                child: Container(
                  color: Theme
                      .of(context)
                      .primaryColorDark,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'A collection of tools, libs, and plug-ins I used:',
                      style: TextStyle(fontSize: 16, height: 2),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 8,
                        children: [
                          Chip(
                            backgroundColor: Color(0xFFDAC9FF),
                            label: Text(
                              'Flutter',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                          Chip(
                            backgroundColor: Color(0xFFDAC9FF),
                            label: Text(
                              'Google Fonts',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                          Chip(
                            backgroundColor: Color(0xFFDAC9FF),
                            label: Text(
                              'Android Studio',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                          Chip(
                            backgroundColor: Color(0xFFDAC9FF),
                            label: Text(
                              'Jiffy',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                          Chip(
                            label: Text(
                              'Provider',
                              style: TextStyle(color: Colors.black87),
                            ),
                            backgroundColor: Color(0xFFDAC9FF),
                          ),
                          Chip(
                            label: Text(
                              'Flutter Charts',
                              style: TextStyle(color: Colors.black87),
                            ),
                            backgroundColor: Color(0xFFDAC9FF),
                          ),
                          Chip(
                            label: Text(
                              'URL Launcher',
                              style: TextStyle(color: Colors.black87),
                            ),
                            backgroundColor: Color(0xFFDAC9FF),
                          ),
                          Chip(
                            backgroundColor: Color(0xFFDAC9FF),
                            label: Text(
                              'Git',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                          Chip(
                            backgroundColor: Color(0xFFDAC9FF),
                            label: Text(
                              'Postman',
                              style: TextStyle(color: Colors.black87),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _getWebpage() async {
    const url =
        'https://documenter.getpostman.com/view/10808728/SzS8rjbc#intro';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
