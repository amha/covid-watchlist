import 'package:covid19_app/Model/Country.dart';
import 'package:flutter/material.dart';

class WatchlistModel extends ChangeNotifier {
  final List<Country> _myWatchlist = [];

  void addCountry(Country country){
    _myWatchlist.add(country);
    notifyListeners();
  }

  List<Country> get items => _myWatchlist;
}
