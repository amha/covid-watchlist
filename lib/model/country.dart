final Map<String, List> suggestions = {
  'Ethiopia': ["Ethiopia", "ET", "10", "20", "30", "40", "50", "60"],
  'USA': ["USA", "USA", "10", "20", "30", "40", "50", "60"]
};

List<Country> listOfCountries(Map map) {
  return map.entries
      .map((e) => Country(e.key, e.value[0], e.value[1], e.value[2], e.value[3],
          e.value[4], e.value[5], e.value[6], false))
      .toList();
}

class Country {
  String name;
  String countryCode;
  String newConfirmed;
  String totalConfirmed;
  String newDeaths;
  String totalDeaths;
  String newRecovered;
  String totalRecovered;
  String critical;
  String casesPerMillion;

  int population;
  bool inWatchList;

  Country(
      String name,
      String code,
      String newConfirmed,
      String totalConfirmed,
      String newDeaths,
      String totalDeaths,
      String newRecovered,
      String totalRecovered,
      bool inWatchlist) {
    this.name = name;
    this.countryCode = code;
    this.newConfirmed = newConfirmed;
    this.totalConfirmed = totalConfirmed;
    this.newRecovered = newConfirmed;
    this.totalRecovered = totalRecovered;
    this.newDeaths = newDeaths;
    this.totalDeaths = totalDeaths;
    //this.population = 0;
    this.inWatchList = false;
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        json['Country'],
        json['CountryCode'],
        json['NewConfirmed'].toString(),
        json['TotalConfirmed'].toString(),
        json['NewDeaths'].toString(),
        json['TotalDeaths'].toString(),
        json['NewRecovered'].toString(),
        json['TotalConfirmed'].toString(),
        false);
  }

  void addToWatchlist() {
    this.inWatchList = true;
  }

  List countryAsList() {
    return [
      this.name,
      this.newRecovered,
      this.totalConfirmed,
      this.newConfirmed
    ];
  }
}
