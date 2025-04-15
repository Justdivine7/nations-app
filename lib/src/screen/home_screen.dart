import 'package:flutter/material.dart';
import 'package:nations_app/src/controller/app_controller.dart';
import 'package:nations_app/src/model/app_model.dart';
import 'package:nations_app/src/widgets/build_body.dart';
import 'package:nations_app/src/widgets/route_observer.dart';
import 'package:nations_app/src/widgets/show_bottom_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  final CountryController controller = CountryController();
  final TextEditingController _searchController = TextEditingController();
  Map<String, List<Country>> _allCountries = {};
  Map<String, List<Country>> _filteredCountries = {};
  bool _isLoading = false;
  bool invalidSearchResult = false;

  // SEARCH LOGIC

  void searchCountries({required String query}) {
    if (query.isEmpty) {
      setState(() {
        _filteredCountries = _allCountries;
      });
      return;
    }

    final Map<String, List<Country>> filteredSearch = {};
    _allCountries.values.expand((list) => list).forEach((country) {
      final name = country.name.toLowerCase();
      final searchText = query.toLowerCase();

      if (name.contains(searchText)) {
        final firstLetter = country.name[0].toUpperCase();
        filteredSearch.putIfAbsent(firstLetter, () => []).add(country);
      }
    });
    setState(() {
      _filteredCountries = filteredSearch;
      invalidSearchResult = filteredSearch.isEmpty;
    });
  }

  // FILTERING BY CONTINENT NAME
  void _filterByContinent(String continent) {
    Map<String, List<Country>> filteredByContinent = {};
    _allCountries.values.expand((list) => list).forEach((country) {
      if (country.continent.toLowerCase() == continent.toLowerCase()) {
        final firstLetter = country.name[0].toUpperCase();
        filteredByContinent.putIfAbsent(firstLetter, () => []).add(country);
      }
    });
    setState(() {
      _filteredCountries = filteredByContinent;
      invalidSearchResult = filteredByContinent.isEmpty;
    });
  }

  // LOGIC TO CONVERT FROM STRING TO INT AND REMOVE COMMAS FROM THE API
  int parseNumber(String populationNumber) {
    return int.tryParse(populationNumber.replaceAll(',', '')) ?? 0;
  }

  // LOGIC TO CONVERT FROM STRING TO INT AND REMOVE COMMAS AND KILOMETER VALUES FROM THE API

  int parseArea(String areaString) {
    return int.tryParse(
          areaString.replaceAll(' km²', '').replaceAll(',', ''),
        ) ??
        0;
  }

  // FILTERING BY POPULATION SIZE
  void _filterByPopulation(int min, int max) {
    Map<String, List<Country>> filteredByPopulation = {};

    _allCountries.values.expand((list) => list).forEach((country) {
      final population = parseNumber(country.population);
      if (population >= min && population <= max) {
        final firstLetter = country.name[0].toUpperCase();
        filteredByPopulation.putIfAbsent(firstLetter, () => []).add(country);
      }
    });
    setState(() {
      _filteredCountries = filteredByPopulation;
      invalidSearchResult = filteredByPopulation.isEmpty;
    });
  }

  // FILTERING BY LAND MASS IN SQUARE METERS
  void _filterBySize(String minSize, String maxSize) {
    Map<String, List<Country>> filteredBySize = {};
    final min = parseArea(minSize);
    final max = parseArea(maxSize);

    _allCountries.values.expand((list) => list).forEach((country) {
      final size = parseArea(country.size);
      if (size >= min && size <= max) {
        final firstLetter = country.name[0].toUpperCase();
        filteredBySize.putIfAbsent(firstLetter, () => []).add(country);
      }
    });
    setState(() {
      _filteredCountries = filteredBySize;
      invalidSearchResult = filteredBySize.isEmpty;
    });
  }

  // LOADING COUNTRIES FROM CONTROLLER
  void loadCountries() async {
    setState(() {
      _isLoading = true;
    });

    final result = await controller.getCountries();
    setState(() {
      _allCountries = result;
      _filteredCountries = result;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  // LOGIC FOR ENSURING THE FULL COUNTRIES LIST SHOWS WHEN THE USER TAPS THE BACK BUTTON FROM THE COUNTRY INFO SCREEN
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    setState(() {
      _searchController.clear();
      _filteredCountries = _allCountries;
      invalidSearchResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Explore',
              style: TextStyle(fontFamily: 'Pacifico', fontSize: 26),
            ),
            Icon(Icons.wb_sunny_outlined),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // SEARCH FIELD
            TextField(
              controller: _searchController,
              onChanged: (value) => searchCountries(query: value),
              onSubmitted: (value) => searchCountries(query: value),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                fillColor: Color.fromRGBO(242, 244, 247, 1),
                filled: true,
                prefixIcon: Icon(Icons.search),
                hintText: '           Search Country',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // RELOAD THE APP
                GestureDetector(
                  onTap: () {
                    loadCountries();
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text('RESET'),
                  ),
                ),
                // SHOWING THE BOTTOM MODAL FOR FILTERING
                ShowBottomModal(
                  onContinentSelected: _filterByContinent,
                  onPopulationRangeSelected: (range) {
                    _filterByPopulation(range['min']!, range['max']!);
                  },
                  onSizeRangeSelected: (sizeRange) {
                    _filterBySize(sizeRange['min']!, sizeRange['max']!);
                  },
                ),
              ],
            ),
            SizedBox(height: 10),

            if (_isLoading)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: LinearProgressIndicator(),
              ),
            if (!_isLoading)
              // THE COUNTRIES LIST MAIN BODY
              Expanded(
                child: BuildBody(
                  filteredCountries: _filteredCountries,
                  invalidSearchResult: invalidSearchResult,
                  searchController: _searchController,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
