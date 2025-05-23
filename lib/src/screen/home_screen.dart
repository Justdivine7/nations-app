import 'package:flutter/material.dart';
import 'package:nations_app/src/controller/app_controller.dart';
import 'package:nations_app/src/model/app_model.dart';
import 'package:nations_app/src/widgets/build_body.dart';
import 'package:nations_app/src/widgets/route_observer.dart';
import 'package:nations_app/src/widgets/shimmer_effect.dart';
import 'package:nations_app/src/widgets/show_bottom_modal.dart';
import 'package:nations_app/src/widgets/text_field_widget.dart';
import 'package:nations_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

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
  bool apiError = false;

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
    try {
      setState(() {
        _isLoading = true;
      });

      final result = await controller.getCountries();
      setState(() {
        _allCountries = result;
        _filteredCountries = result;
        _isLoading = false;
        apiError = false;
      });
    } catch (e) {
      setState(() {
        apiError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadCountries();
    });
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Explore',
              style: TextStyle(fontFamily: 'Pacifico', fontSize: 26),
            ),
            GestureDetector(
              onTap: () => themeProvider.toggleTheme(),
              child: Icon(
                themeProvider.isDarkMode
                    ? Icons.nightlight_outlined
                    : Icons.wb_sunny_outlined,
              ),
            ),
          ],
        ),
      ),
      body:
          apiError
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, color: Colors.red, size: 48),
                    SizedBox(height: 12),
                    Text(
                      'Unable to fetch countries.\nCheck your internet connection.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        CircularProgressIndicator();
                        loadCountries();
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              )
              : _isLoading
              ? ShimmerEffect()
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // SEARCH FIELD
                    TextFieldWidget(
                      searchController: _searchController,
                      onChanged: (value) => searchCountries(query: value),
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

                    // if (_isLoading)
                    //   Padding(
                    //     padding: EdgeInsets.symmetric(vertical: 10),
                    //     child: LinearProgressIndicator(),
                    //   ),
                    // if (!_isLoading)
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
