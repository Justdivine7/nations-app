import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nations_app/src/model/app_model.dart';
import 'package:nations_app/src/widgets/build_rich_text.dart';

class CountryInfo extends StatelessWidget {
  final Country country;
  const CountryInfo({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),

      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Center(child: Text(country.name)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // FLAG
              Center(
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.25,
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),

                    child: CachedNetworkImage(
                      imageUrl: country.href!.flag,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => Center(
                            child: Transform.scale(
                              scale: 0.7,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      errorWidget:
                          (context, url, error) =>
                              Center(child: Icon(Icons.flag_circle)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.025),
              // INFORMATION
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildRichText(title: 'Capital:', value: country.capital),
                  BuildRichText(title: 'Continent:', value: country.continent),
                  BuildRichText(title: 'Full Name:', value: country.fullName),
                  BuildRichText(
                    title: 'Independence Date:',
                    value: country.independenceDate,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.025),
              // INFORMATION
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildRichText(
                    title: 'Population:',
                    value: country.population,
                  ),
                  BuildRichText(
                    title: 'Current President:',
                    value:
                        country.currentPresident == null ||
                                country.currentPresident!.name.isEmpty
                            ? 'Not available'
                            : country.description,
                  ),
                  BuildRichText(title: 'Currency:', value: country.currency),
                ],
              ),
              SizedBox(height: size.height * 0.025),
              // INFORMATION
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildRichText(title: 'Phone Code:', value: country.phoneCode),
                  BuildRichText(title: 'Size:', value: country.size),
                  BuildRichText(
                    title: 'Description:',
                    value:
                        country.description.isEmpty
                            ? 'Not available'
                            : country.description,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
