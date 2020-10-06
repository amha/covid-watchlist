import 'package:covid19_app/model/watchlistModel.dart';
import 'package:covid19_app/view/home.dart';
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
        title: 'C19 Tracker',
        theme: ThemeData(
            // text
            textTheme:
                GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
            // colors
            brightness: Brightness.light,
            primaryColor: Color(0xFF202BFF),
            accentColor: Color(0xFF202BFF),
            primaryColorDark: Color(0xFF0010ee),
            primaryIconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color(0xFFF5F5F7),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            // components
            appBarTheme: AppBarTheme(
                color: Color(0xFFFFFFFF),
                elevation: 0,
                textTheme: TextTheme(
                    headline6: TextStyle(
                        color: Color(0xFF202BFF),
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                iconTheme: IconThemeData(color: Color(0xFF202BFF))),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
                selectedItemColor: Theme.of(context).appBarTheme.color,
                unselectedItemColor: Colors.black,
                backgroundColor: Colors.white,
                elevation: 0)),
        home: Watchlist());
  }
}
