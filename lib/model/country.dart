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
  'Ethiopia': [100, true],
  'United States': [100, true],
  'Kenya': [100, true],
  'Israel': [100, true],
};

List<Country> listOfCountries(Map map) {
  return map.entries
      .map((e) => Country(e.key, e.value[0], e.value[1]))
      .toList();
}

class Country {
  String name;
  int population;
  bool hasFlag;
  bool inWatchList;

  Country(String name, int population, bool flag) {
    this.name = name;
    this.population = population;
    this.hasFlag = flag;
    this.inWatchList = false;
  }

  void addToWatchlist() {
    this.inWatchList = true;
  }
}
