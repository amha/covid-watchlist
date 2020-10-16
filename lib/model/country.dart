final Map<String, List> allCountries = {
  'Afghanistan': [38928346, false],
  'Albania': [2877797, false],
  'Algeria': [43851044, false],
  'Andorra': [77265, false],
  'Angola': [32866272, false],
  'Antigua and Barbuda': [97929, false],
  'Argentina': [45195774, false],
  'Armenia': [2963243, false],
  'Australia': [25499884, false],
  'Austria': [9006398, false],
  'Azerbaijan': [10139177, false],
  'Bahamas': [393244, false],
  'Bahrain': [1701575, false],
  'Bangladesh': [164689383, false],
  'Barbados': [287375, false],
  'Belarus': [9449323, false],
  'Belgium': [11589623, false],
  'Belize': [397628, false],
  'Benin': [12123200, false],
  'Bhutan': [771608, false],
  'Bolivia': [11673021, false],
  'Bosnia and Herzegovina': [3280819, false],
  'Botswana': [2351627, false],
  'Brazil': [212559417, false],
  'Brunei': [437479, false],
  'Bulgaria': [6948445, false],
  'Burkina Faso': [20903273, false],
  'Burundi': [11890784, false]
};

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
  bool hasFlag;
  bool inWatchList;

  Country(String name, String activeCases, String totalCases, String newCases) {
    this.name = name;
    this.activeCases = activeCases;
    this.totalCases = totalCases;
    this.newCases = newCases;
    this.population = 0;
    this.hasFlag = false;
    this.inWatchList = false;
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(json['country'], json['active_cases'], json['total_cases'],
        json['new_cases']);
  }

  void addToWatchlist() {
    this.inWatchList = true;
  }

  List countryAsList() {
    return [this.name, this.activeCases, this.totalCases, this.newCases];
  }
}
