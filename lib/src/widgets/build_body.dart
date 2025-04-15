import 'package:flutter/material.dart';
import 'package:nations_app/src/model/app_model.dart';
import 'package:nations_app/src/widgets/country_tile.dart';

class BuildBody extends StatelessWidget {
  final Map<String, List<Country>> filteredCountries;
  final TextEditingController searchController;

  final bool invalidSearchResult;
  const BuildBody({
    super.key,
    required this.filteredCountries,
    required this.invalidSearchResult,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    if (invalidSearchResult) {
      return Center(child: Text('No Result, check country or capital name'));
    }
    if (filteredCountries.isEmpty) {
      return Center(child: Text('No countries found'));
    }
    return ListView.builder(
      itemCount: filteredCountries.length,
      itemBuilder: (context, index) {
        String letter = filteredCountries.keys.elementAt(index);
        List<Country> countries = filteredCountries[letter]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                letter,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ...countries.map(
              (country) => CountryTile(
                country: country,
                searchController: searchController,
              ),
            ),
          ],
        );
      },
    );
  }
}
