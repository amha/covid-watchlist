// Copyright 2021 Amha Mogus. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:covid19_app/model/watchlistModel.dart';
import 'package:covid19_app/view/launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => WatchlistModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid Watchlist',
        theme: ThemeData(
          // text
            textTheme:
            GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
            // colors
            brightness: Brightness.dark,
            primaryColor: Color(0xFF8B7CFF),
            accentColor: Color(0xFFFFE87F),
            primaryColorDark: Color(0xFF685CC3),
            primaryIconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xFF151515),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            // components
            appBarTheme: AppBarTheme(
                color: Color(0xFF000000),
                elevation: 0,
                iconTheme: IconThemeData(color: Color(0xFFFFFFFF))),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w800, color: Color(0xFF8B7CFF)),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
                selectedItemColor: Color(0xFF8B7CFF),
                unselectedItemColor: Colors.white,
                backgroundColor: Colors.black,
                elevation: 0)),
        home: Launcher());
  }
}
