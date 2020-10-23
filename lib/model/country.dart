final Map<String, List> suggestions = {
  // 'Ethiopia': [100, true],
  // 'United States': [100, true],
  // 'Kenya': [100, true],
  // 'Israel': [100, true],
  'Ethiopia': ["Ethiopia", "ET", "244", "23"],
  'USA': ["USA", "USA", "145", "21"]
};

List<Country> listOfCountries(Map map) {
  return map.entries
      .map((e) => Country(e.key, e.value[0], e.value[1], "dummy"))
      .toList();
}

class Country {
  String name;
  String abbreviation;
  String totalCases;
  String newCases;
  String totalDeaths;
  String newDeaths;
  String totalRecovered;
  String activeCases;
  String critical;
  String casesPerMillion;

  int population;
  bool inWatchList;

  Country(String name, String activeCases, String totalCases, String newCases) {
    this.name = name;
    this.activeCases = activeCases;
    this.totalCases = totalCases;
    this.newCases = newCases;
    //this.population = 0;
    this.inWatchList = false;
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(json['Country'], json['TotalRecovered'].toString(),
        json['TotalConfirmed'].toString(), json['NewConfirmed'].toString());
  }

  void addToWatchlist() {
    this.inWatchList = true;
  }

  List countryAsList() {
    return [this.name, this.activeCases, this.totalCases, this.newCases];
  }
}
