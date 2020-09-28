import 'package:covid19_app/Model/watchlistModel.dart';
import 'package:covid19_app/screens/watchlist.dart';
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
          textTheme:
              GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.blue,
          primaryColorDark: Colors.blueAccent,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Watchlist());
  }
}
