final Map<String, int> allCountries = {
  'Afghanistan': 38928346,
  'Albania': 2877797,
  'Algeria': 43851044,
  'Andorra': 77265,
  'Angola': 32866272,
  'Antigua and Barbuda': 97929,
  'Argentina': 45195774,
  'Armenia': 2963243,
  'Australia': 25499884,
  'Austria': 9006398,
  'Azerbaijan': 10139177,
  'Bahamas': 393244,
  'Bahrain': 1701575,
  'Bangladesh': 164689383,
  'Barbados': 287375,
  'Belarus': 9449323,
  'Belgium': 11589623,
  'Belize': 397628,
  'Benin': 12123200,
  'Bhutan': 771608,
  'Bolivia': 11673021,
  'Bosnia and Herzegovina': 3280819,
  'Botswana': 2351627,
  'Brazil': 212559417,
  'Brunei': 437479,
  'Bulgaria': 6948445,
  'Burkina Faso': 20903273,
  'Burundi': 11890784
};

final Map<String, int> suggestions = {
  'Ethiopia': 100,
  'United States': 200,
  'Kenya': 300,
  'Israel': 400,
};

List listOfCountries(Map map) {
  return map.entries.map((e) => Country(e.key, e.value)).toList();
}
class Country {
  String name;
  int population;

  Country(String name, int population) {
    this.name = name;
    this.population = population;
  }
}
