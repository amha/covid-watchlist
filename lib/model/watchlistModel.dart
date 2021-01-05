// Copyright 2021 Amha Mogus. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:covid19_app/model/country.dart';
import 'package:flutter/material.dart';

class WatchlistModel extends ChangeNotifier {
  final List<Country> _myWatchlist = [];

  void addCountry(Country country) {
    _myWatchlist.add(country);
    notifyListeners();
  }

  void clearWatchlist() {
    _myWatchlist.clear();
    notifyListeners();
  }

  void removeCountry(Country country) {
    _myWatchlist.remove(country);
    notifyListeners();
  }

  List<Country> get items => _myWatchlist;
}
