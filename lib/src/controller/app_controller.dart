import 'dart:convert';

import 'package:nations_app/src/model/app_model.dart';
import 'package:nations_app/src/repository/app_repository.dart';

class CountryController {
  final CountryRepo repo = CountryRepo();
  Future<Map<String, List<Country>>> getCountries() async {
    final response = await repo.getCountries();
    final data = jsonDecode(response.body);

    final countryJson = data['data'];
    List<Country> countriesList = [];
   

    for (Map<String, dynamic> country in countryJson) {
      countriesList.add(Country.fromJson(country));
    }

    // OR
    // List<Country> countriesList =  countryJson.map((country)=> Country.fromJson(country)).toList();
    // return countriesList;

    Map<String, List<Country>> groupedCountries = {};
    for (var country in countriesList) {
      String firstLetter = country.name[0].toUpperCase();
      if (!groupedCountries.containsKey(firstLetter)) {
        groupedCountries[firstLetter] = [];
      }
      groupedCountries[firstLetter]!.add(country);
    
    }
    

    return groupedCountries;
  }
}
