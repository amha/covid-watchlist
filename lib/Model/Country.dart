final Map<String, List> allCountries = {
  'Afghanistan': [38928346, false],
  // 'Albania': 2877797,
  // 'Algeria': 43851044,
  // 'Andorra': 77265,
  // 'Angola': 32866272,
  // 'Antigua and Barbuda': 97929,
  // 'Argentina': 45195774,
  // 'Armenia': 2963243,
  // 'Australia': 25499884,
  // 'Austria': 9006398,
  // 'Azerbaijan': 10139177,
  // 'Bahamas': 393244,
  // 'Bahrain': 1701575,
  // 'Bangladesh': 164689383,
  // 'Barbados': 287375,
  // 'Belarus': 9449323,
  // 'Belgium': 11589623,
  // 'Belize': 397628,
  // 'Benin': 12123200,
  // 'Bhutan': 771608,
  // 'Bolivia': 11673021,
  // 'Bosnia and Herzegovina': 3280819,
  // 'Botswana': 2351627,
  // 'Brazil': 212559417,
  // 'Brunei': 437479,
  // 'Bulgaria': 6948445,
  // 'Burkina Faso': 20903273,
  // 'Burundi': 11890784
};

final Map<String, List> suggestions = {
  'Ethiopia': [100,true],
  'United States': [100,true],
  'Kenya': [100,true],
  'Israel': [100,true],
};

List<Country> listOfCountries(Map map) {
  print(map.toString());
  return map.entries.map((e) => Country(e.key, e.value[0], e.value[1])).toList();
}

class Country {
  String name;
  int population;
  bool hasFlag;

  Country(String name, int population, bool flag) {
    this.name = name;
    this.population = population;
    this.hasFlag = flag;
  }
}
